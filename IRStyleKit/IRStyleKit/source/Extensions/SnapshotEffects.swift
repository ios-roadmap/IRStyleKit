//  SnapshotEffects.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 10.05.2025.
//

//import SwiftUI
//import CoreImage
//import CoreImage.CIFilterBuiltins
//
//// MARK: - Public façade
//@available(iOS 16, *)
//public enum SnapshotEffects {
//
//    /// Chainable post‑processing primitives.
//    public enum Effect {
//        case blur(radius: Double)
//        case roundedCorners(CGFloat)
//        case shadow(radius: CGFloat,
//                    offset: CGSize  = .zero,
//                    colour: UIColor = .black,
//                    opacity: Float  = 0.25)
//        case mask(UIBezierPath)          // for fully custom shapes
//    }
//
//    /// Applies **`effects`** in order and returns a new `UIImage`.
//    @MainActor
//    public static func apply(_ effects: [Effect], to image: UIImage) -> UIImage {
//        effects.reduce(image) { output, effect in
//            switch effect {
//            case .blur(let r):           return output.blurred(radius: r)     ?? output
//            case .roundedCorners(let r): return output.corners(radius: r)      ?? output
//            case let .shadow(r, o, c, a):return output.withShadow(radius: r,
//                                                                  offset: o,
//                                                                  colour: c,
//                                                                  opacity: a) ?? output
//            case .mask(let path):        return output.masked(with: path)      ?? output
//            }
//        }
//    }
//}
//
//// MARK: - UIImage helpers
//private extension UIImage {
//
//    /// Gaussian blur via Core Image.
//    func blurred(radius: Double) -> UIImage? {
//        let ctx     = CIContext()
//        let filter  = CIFilter.gaussianBlur()
//        filter.radius = Float(radius)
//        guard
//            let input  = CIImage(image: self)                   else { return nil }
//        filter.inputImage = input
//        guard let output  = filter.outputImage?
//                .cropped(to: input.extent),
//              let cgImage = ctx.createCGImage(output, from: input.extent)
//        else { return nil }
//        return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
//    }
//
//    /// Rounded‑rectangle clipping.
//    func corners(radius: CGFloat) -> UIImage? {
//        UIGraphicsImageRenderer(size: size).image { _ in
//            let rect = CGRect(origin: .zero, size: size)
//            UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
//            draw(in: rect)
//        }
//    }
//
//    /// Adds a soft shadow around the image bounds.
//    func withShadow(radius: CGFloat,
//                    offset: CGSize,
//                    colour: UIColor,
//                    opacity: Float) -> UIImage? {
//
//        let shadowRect = CGRect(origin: .zero,
//                                size: CGSize(width: size.width  + 2 * radius,
//                                             height: size.height + 2 * radius))
//        return UIGraphicsImageRenderer(size: shadowRect.size)
//            .image { ctx in
//                ctx.cgContext.setShadow(offset: offset,
//                                        blur: radius,
//                                        color: colour.withAlphaComponent(CGFloat(opacity)).cgColor)
//                draw(at: CGPoint(x: radius, y: radius))
//            }
//    }
//
//    /// Clips the image to an arbitrary path.
//    func masked(with path: UIBezierPath) -> UIImage? {
//        UIGraphicsImageRenderer(size: size).image { _ in
//            path.addClip()
//            draw(at: .zero)
//        }
//    }
//}
//
//// MARK: - SwiftUI sugar
//@available(iOS 16, *)
//public extension View {
//
//    /// Captures the view **and** applies `SnapshotEffects`.
//    @MainActor
//    func snapshot(
//        scale: CGFloat? = nil,
//        effects: [SnapshotEffects.Effect] = []
//    ) -> UIImage? {
//        guard
//            let raw = SnapshotManager.captureImage(self, scale: scale)
//        else { return nil }
//
//        return effects.isEmpty ? raw
//                               : SnapshotEffects.apply(effects, to: raw)
//    }
//}
