//
//  SnapshotPDFExportDemo.swift
//  IRStyleKitDemo
//
//  Created by Ömer Faruk Öztürk on 10.05.2025.
//

import SwiftUI
import IRStyleKit

struct SnapshotPDFExportDemo: View {
    @State private var exportedPDFURL: URL?

    var body: some View {
        VStack(spacing: 20) {
            demoCard
                .shadow(radius: 5)

            if let url = exportedPDFURL {
                ShareLink(item: url) {
                    Label("Share Exported PDF", systemImage: "square.and.arrow.up")
                }
            }
        }
        .onAppear {
            exportSnapshotAsPDF()
        }
        .padding()
        .navigationTitle("PDF Snapshot Demo")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var demoCard: some View {
        VStack(spacing: 10) {
            Text("Snapshot Demo")
                .font(.headline)

            Text("This is a demo card for exporting SwiftUI view as PDF.")
                .font(.subheadline)
                .multilineTextAlignment(.center)

            Text("IRStyleKit Snapshot API")
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .frame(width: 250, height: 150)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [.indigo, .cyan],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
        )
        .foregroundColor(.white)
    }

    @MainActor
    private func exportSnapshotAsPDF() {
        let tempURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString + ".pdf")

        do {
            try demoCard
                .snapshotRenderer()
                .writeSnapshotPDF(to: tempURL, pageSize: CGSize(width: 300, height: 200))
            exportedPDFURL = tempURL
        } catch {
            print("Snapshot PDF export failed:", error)
        }
    }
}

#Preview {
    SnapshotPDFExportDemo()
}
