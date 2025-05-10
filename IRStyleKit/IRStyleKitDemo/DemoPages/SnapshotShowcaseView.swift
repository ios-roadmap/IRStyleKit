//  SnapshotRendererDemo.swift
//  IRStyleKitDemo
//
//  Created by Ömer Faruk Öztürk on 10 May 2025.
//
//  Showcases every post‑processing option offered by `SnapshotRenderer` in a
//  purely SwiftUI (iOS 17+) environment.

//import SwiftUI
//import IRStyleKit
//
//@available(iOS 17, *)
//struct SnapshotRendererDemo: View {
//    // MARK: – Effect catalogue
//
//    private struct EffectDemo: Identifiable {
//        let id    = UUID()
//        let title: String
//        /// Takes a *type‑erased* renderer and returns a new one with extra effects.
//        /// Using `AnyView` sidesteps generic‑closure limitations.
//        let configure: (SnapshotRenderer<AnyView>) -> SnapshotRenderer<AnyView>
//    }
//
//    private static let maskPath: CGPath = {
//        let rect = CGRect(origin: .zero, size: CGSize(width: 200, height: 120))
//        return CGPath(roundedRect: rect, cornerWidth: 24, cornerHeight: 24, transform: nil)
//    }()
//
//    private let demos: [EffectDemo] = [
//        .init(title: "Blur (radius 5)")        { $0.blur(5) },
//        .init(title: "Rounded Corners (12)")   { $0.roundedCorners(12) },
//        .init(title: "Shadow (4 pt, 3×3)")     { $0.shadow(radius: 4, offset: .init(width: 3, height: 3)) },
//        .init(title: "Mask (Custom Path)")     { $0.mask(maskPath) }
//    ]
//
//    // MARK: – State
//
//    @State private var originals: [UUID: Image] = [:]
//    @State private var effected:  [UUID: Image] = [:]
//    @State private var showOriginal: [UUID: Bool] = [:]
//
//    // MARK: – Body
//
//    var body: some View {
//        ScrollView {
//            snapshotTarget
//                .padding(.vertical, 40)
//
//            LazyVStack(spacing: 28) {
//                ForEach(demos) { demo in
//                    SnapshotCard(title: demo.title,
//                                 image: display(for: demo),
//                                 toggled: showOriginal[demo.id] ?? false) {
//                        toggle(for: demo)
//                    }
//                }
//            }
//            .padding(.horizontal)
//        }
//        .navigationTitle("Snapshot Renderer")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//
//    // MARK: – Actions
//
//    @MainActor
//    private func toggle(for demo: EffectDemo) {
//        if originals[demo.id] == nil {
//            // First tap ⇒ capture both variants.
//            let baseRenderer = SnapshotRenderer(AnyView(snapshotTarget))
//            originals[demo.id] = baseRenderer.image()
//            effected[demo.id]  = demo.configure(baseRenderer).image()
//            showOriginal[demo.id] = false
//        } else {
//            showOriginal[demo.id]?.toggle()
//        }
//    }
//
//    private func display(for demo: EffectDemo) -> Image? {
//        (showOriginal[demo.id] ?? false) ? originals[demo.id] : effected[demo.id]
//    }
//
//    // MARK: – Target view (what we snapshot)
//
//    private var snapshotTarget: some View {
//        VStack(spacing: 8) {
//            Image(systemName: "camera.viewfinder")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 48)
//            Text("Snapshot")
//                .font(.headline)
//        }
//        .padding()
//        .frame(width: 220, height: 130)
//        .background(.indigo, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
//        .foregroundStyle(.white)
//        .shadow(radius: 4)
//    }
//}
//
//// MARK: – Snapshot card
//
//@available(iOS 17, *)
//private struct SnapshotCard: View {
//    let title: String
//    let image: Image?
//    let toggled: Bool
//    let tap: () -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            Text(title).font(.headline)
//
//            Button(action: tap) {
//                Label(toggled ? "Show Effect" : "Show Original", systemImage: "photo")
//                    .frame(maxWidth: .infinity)
//            }
//            .buttonStyle(.borderedProminent)
//
//            Group {
//                if let img = image {
//                    img
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxHeight: 140)
//                        .clipShape(RoundedRectangle(cornerRadius: 8))
//                } else {
//                    placeholder
//                }
//            }
//            .animation(.easeInOut, value: toggled)
//        }
//    }
//
//    private var placeholder: some View {
//        RoundedRectangle(cornerRadius: 8, style: .continuous)
//            .fill(.secondary.opacity(0.1))
//            .frame(height: 140)
//            .overlay(Text("Preview").foregroundStyle(.secondary))
//    }
//}
//
//// MARK: – Preview
//
//@available(iOS 17, *)
//#Preview {
//    NavigationStack { SnapshotRendererDemo() }
//}
