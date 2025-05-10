//
//  SnapshotRenderer.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 10.05.2025.
//

/*
 SnapshotRenderer.swift
 IRStyleKit
 
 Created by Ömer Faruk Öztürk on 10 May 2025.
 
 iOS 17‑only (SwiftUI 5) snapshot utility written *without* importing UIKit.
 It captures any SwiftUI view as a `CGImage`, transforms it via an internal
 chain of Core Graphics/Core Image effects, and optionally writes a single‑page
 PDF.  All interaction is handled through a fluent builder so call‑sites stay
 elegant:
 
 ```swift
 let cgImage = MyCard()
     .renderer()
     .roundedCorners(16)
     .shadow(radius: 6)
     .blur(3)
     .cgImage()
 ```
 */

import SwiftUI
import CoreGraphics
import CoreImage
import CoreImage.CIFilterBuiltins

@available(iOS 17, *)
public struct SnapshotRenderer<V: View> {
    // MARK: - Snapshot Effect Model

    private enum SnapshotEffect {
        case blur(Double)
        case roundedCorners(CGFloat)
        case shadow(radius: CGFloat, offset: CGSize, colour: CGColor, opacity: Float)
        case mask(CGPath)
    }

    private let view: V
    private var effects: [SnapshotEffect] = []

    public init(_ view: V) {
        self.view = view
    }

    // MARK: - Fluent API

    public func withSnapshotBlur(_ radius: Double) -> Self {
        mutatingCopy { $0.effects.append(.blur(radius)) }
    }

    public func withSnapshotRoundedCorners(_ radius: CGFloat) -> Self {
        mutatingCopy { $0.effects.append(.roundedCorners(radius)) }
    }

    public func withSnapshotShadow(
        radius: CGFloat,
        offset: CGSize = .zero,
        colour: CGColor = CGColor(gray: 0, alpha: 1),
        opacity: Float = 0.25
    ) -> Self {
        mutatingCopy {
            $0.effects.append(.shadow(radius: radius, offset: offset, colour: colour, opacity: opacity))
        }
    }

    public func withSnapshotMask(_ path: CGPath) -> Self {
        mutatingCopy { $0.effects.append(.mask(path)) }
    }

    // MARK: - Rendering

    /// Rasterises the SwiftUI view, applies effects, and returns a `CGImage`.
    @MainActor
    public func cgImage(scale: CGFloat? = nil) -> CGImage? {
        let renderer = ImageRenderer(content: view)
        renderer.scale = scale ?? UIScreen.main.scale
        guard let base = renderer.cgImage else { return nil }
        return applySnapshotEffects(effects, to: base)
    }

    /// Converts the `CGImage` into a SwiftUI `Image`.
    @MainActor
    public func snapshotImage(scale: CGFloat? = nil) -> Image? {
        guard let cg = cgImage(scale: scale) else { return nil }
        return Image(decorative: cg, scale: UIScreen.main.scale)
    }

    /// Writes a single‑page PDF at `url` with the specified page size.
    @MainActor
    public func writeSnapshotPDF(to url: URL, pageSize: CGSize) throws {
        var thrown: Error?
        let renderer = ImageRenderer(content: view)
        renderer.render { _, draw in
            var mediaBox = CGRect(origin: .zero, size: pageSize)
            guard let ctx = CGContext(url as CFURL, mediaBox: &mediaBox, nil) else {
                thrown = CocoaError(.fileWriteUnknown)
                return
            }
            ctx.beginPDFPage(nil)
            draw(ctx)
            ctx.endPDFPage()
            ctx.closePDF()
        }
        if let error = thrown { throw error }
    }

    // MARK: - Internal Helpers

    private func mutatingCopy(_ mutate: (inout SnapshotRenderer) -> Void) -> SnapshotRenderer {
        var copy = self
        mutate(&copy)
        return copy
    }

    private func applySnapshotEffects(_ effects: [SnapshotEffect], to base: CGImage) -> CGImage {
        guard effects.isEmpty == false else { return base }

        return effects.reduce(base) { image, effect in
            switch effect {
            case .blur(let r):              return image.applyingSnapshotBlur(radius: r) ?? image
            case .roundedCorners(let r):    return image.applyingSnapshotRoundedCorners(radius: r) ?? image
            case let .shadow(r, o, c, a):   return image.applyingSnapshotShadow(radius: r, offset: o, colour: c, opacity: a) ?? image
            case .mask(let p):              return image.applyingSnapshotMask(path: p) ?? image
            }
        }
    }
}

// MARK: - Snapshot Image Effects (CGImage Extensions)

private extension CGImage {
    func applyingSnapshotBlur(radius: Double) -> CGImage? {
        let context = CIContext()
        let filter = CIFilter.gaussianBlur()
        filter.radius = Float(radius)
        let input = CIImage(cgImage: self)
        filter.inputImage = input

        guard let output = filter.outputImage?.cropped(to: input.extent),
              let cg = context.createCGImage(output, from: input.extent) else {
            return nil
        }
        return cg
    }

    func applyingSnapshotRoundedCorners(radius: CGFloat) -> CGImage? {
        let width = width
        let height = height
        guard let ctx = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return nil
        }

        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        ctx.beginPath()
        ctx.addPath(CGPath(roundedRect: rect, cornerWidth: radius, cornerHeight: radius, transform: nil))
        ctx.clip()
        ctx.draw(self, in: rect)

        return ctx.makeImage()
    }

    func applyingSnapshotShadow(
        radius: CGFloat,
        offset: CGSize,
        colour: CGColor,
        opacity: Float
    ) -> CGImage? {
        let pad = Int(radius * 2)
        let widthWithShadow = width + pad
        let heightWithShadow = height + pad

        guard let ctx = CGContext(
            data: nil,
            width: widthWithShadow,
            height: heightWithShadow,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return nil
        }

        ctx.setShadow(offset: offset, blur: radius, color: colour.copy(alpha: CGFloat(opacity)))
        ctx.draw(
            self,
            in: CGRect(
                x: CGFloat(pad) / 2,
                y: CGFloat(pad) / 2,
                width: CGFloat(width),
                height: CGFloat(height)
            )
        )

        return ctx.makeImage()
    }

    func applyingSnapshotMask(path: CGPath) -> CGImage? {
        guard let ctx = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return nil
        }

        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        ctx.beginPath()
        ctx.addPath(path)
        ctx.clip()
        ctx.draw(self, in: rect)

        return ctx.makeImage()
    }
}

// MARK: - SwiftUI View Sugar

public extension View {
    /// Quick snapshot without effects.
    @MainActor
    func snapshotImage(scale: CGFloat? = nil) -> Image? {
        SnapshotRenderer(self).snapshotImage(scale: scale)
    }

    /// Starts snapshot renderer builder.
    @MainActor
    func snapshotRenderer() -> SnapshotRenderer<Self> {
        SnapshotRenderer(self)
    }
}
