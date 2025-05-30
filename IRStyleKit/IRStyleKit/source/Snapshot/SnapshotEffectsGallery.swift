//  SnapshotEffectsGallery.swift
//  IRStyleKitDemo
//
//  Created by Ömer Faruk Öztürk on 10.05.2025.
//  Built using SnapshotRenderer (iOS 17+ only).

import SwiftUI
import IRStyleKit

@available(iOS 17, *)
struct SnapshotEffectsGallery: View {
    // MARK: - State

    @State private var capturedOriginal: Image?
    @State private var capturedEffected: [EffectKind: Image] = [:]
    @State private var shownEffect: EffectKind?
    @State private var exportedPDFURL: URL?

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                snapshotPreview
                effectButtons
                resultPreview
                if let url = exportedPDFURL {
                    ShareLink(item: url) {
                        Label("Share Exported PDF", systemImage: "square.and.arrow.up")
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Snapshot Gallery")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Snapshot Target

    private var snapshotTarget: some View {
        VStack(spacing: 6) {
            Image(systemName: "camera.viewfinder")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
            Text("Snapshot")
                .font(.headline)
        }
        .padding()
        .frame(width: 220, height: 130)
        .background(Color.indigo)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 4)
    }

    private var snapshotPreview: some View {
        snapshotTarget
            .onAppear {
                capturedOriginal = snapshotTarget.snapshotImage()
                EffectKind.allCases.forEach { kind in
                    capturedEffected[kind] = kind.renderer(for: snapshotTarget).snapshotImage()
                }

                if let image = shownEffect.flatMap({ capturedEffected[$0] }) ?? capturedOriginal {
                    exportImageAsPDF(image: image)
                }
            }
    }

    private var effectButtons: some View {
        VStack(spacing: 12) {
            ForEach(EffectKind.allCases) { effect in
                Button(action: {
                    shownEffect = effect
                    if let img = capturedEffected[effect] {
                        exportImageAsPDF(image: img)
                    }
                }) {
                    Text(effect.label)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }

            Button("Show Original") {
                shownEffect = nil
                if let img = capturedOriginal {
                    exportImageAsPDF(image: img)
                }
            }
            .buttonStyle(.bordered)
        }
    }

    private var resultPreview: some View {
        Group {
            if let img = shownEffect.flatMap({ capturedEffected[$0] }) ?? capturedOriginal {
                img
                    .resizable()
                    .scaledToFit()
                    .frame(height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                placeholder
            }
        }
        .animation(.easeInOut, value: shownEffect)
    }

    private var placeholder: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.secondary.opacity(0.1))
            .frame(height: 160)
            .overlay(Text("No Image").foregroundStyle(.secondary))
    }

    // MARK: - PDF Export

    @MainActor
    private func exportImageAsPDF(image: Image) {
        let pageSize = CGSize(width: 300, height: 200)
        let tempURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString + ".pdf")

        let renderer = ImageRenderer(content:
            image
                .resizable()
                .scaledToFit()
                .frame(width: pageSize.width, height: pageSize.height)
        )

        var thrown: Error?

        renderer.render { size, render in
            var mediaBox = CGRect(origin: .zero, size: pageSize)
            guard let ctx = CGContext(tempURL as CFURL, mediaBox: &mediaBox, nil) else {
                thrown = CocoaError(.fileWriteUnknown)
                return
            }

            ctx.beginPDFPage(nil)
            render(ctx)
            ctx.endPDFPage()
            ctx.closePDF()
        }

        if let error = thrown {
            print("PDF export failed:", error)
        } else {
            exportedPDFURL = tempURL
        }
    }
}

@available(iOS 17, *)
private enum EffectKind: String, CaseIterable, Identifiable {
    case blur, rounded, shadow, mask

    var id: String { rawValue }

    var label: String {
        switch self {
        case .blur: return "Blur (radius: 5)"
        case .rounded: return "Rounded Corners (12)"
        case .shadow: return "Shadow (radius: 4, offset: (3,3))"
        case .mask: return "Mask (Custom Path)"
        }
    }

    @MainActor
    func renderer(for view: some View) -> SnapshotRenderer<some View> {
        switch self {
        case .blur:
            return view.snapshotRenderer().withSnapshotBlur(5)
        case .rounded:
            return view.snapshotRenderer().withSnapshotRoundedCorners(12)
        case .shadow:
            return view.snapshotRenderer().withSnapshotShadow(radius: 4, offset: CGSize(width: 3, height: 3))
        case .mask:
            let path = CGPath(roundedRect: CGRect(x: 0, y: 0, width: 200, height: 120), cornerWidth: 24, cornerHeight: 24, transform: nil)
            return view.snapshotRenderer().withSnapshotMask(path)
        }
    }
}

@available(iOS 17, *)
#Preview {
    NavigationStack {
        SnapshotEffectsGallery()
    }
}
