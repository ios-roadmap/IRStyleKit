//
//  SnapshotManager.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 10.05.2025.
//

//// MARK: - SnapshotManager.swift
//import SwiftUI
//import PDFKit
//
///// A lightweight, SwiftUI‑only façade that renders SwiftUI views as `UIImage`s or single‑page PDFs.
//@available(iOS 16, *)
//public enum SnapshotManager {
//
//    // MARK: Image capture
//    /// Returns a rasterised `UIImage` representation of **`view`** using `ImageRenderer`.
//    @MainActor
//    public static func captureImage<V: View>(
//        _ view: V,
//        scale: CGFloat? = nil
//    ) -> UIImage? {
//        let renderer = ImageRenderer(content: view)
//        renderer.scale = scale ?? UIScreen.main.scale
//        return renderer.uiImage
//    }
//
//    // MARK: PDF export
//    /// Exports **`view`** into a single‑page PDF at **`url`** with **`pageSize`**.
//    @MainActor
//    public static func exportPDF<V: View>(
//        _ view: V,
//        to url: URL,
//        pageSize: CGSize
//    ) throws {
//        let renderer = ImageRenderer(content: view)
//
//        var result: Error?
//        renderer.render { _, draw in
//            var mediaBox = CGRect(origin: .zero, size: pageSize)
//            guard let ctx = CGContext(url as CFURL, mediaBox: &mediaBox, nil) else {
//                result = CocoaError(.fileWriteUnknown)
//                return
//            }
//            ctx.beginPDFPage(nil)
//            draw(ctx) // vector‑quality drawing ✨
//            ctx.endPDFPage()
//            ctx.closePDF()
//        }
//        if let error = result { throw error }
//    }
//}
