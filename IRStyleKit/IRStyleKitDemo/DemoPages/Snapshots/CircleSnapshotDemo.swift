//
//  CircleSnapshotDemo.swift
//  IRStyleKitDemo
//
//  Created by Ömer Faruk Öztürk on 10.05.2025.
//

import SwiftUI
import IRStyleKit

struct CircleSnapshotDemo: View {
    @State private var snapshot: Image?

    var body: some View {
        VStack(spacing: 12) {
            circle

            Button("Capture") {
                snapshot = circle
                    .snapshotRenderer()
                    .withSnapshotRoundedCorners(75)
                    .withSnapshotShadow(radius: 16)
                    .snapshotImage()
            }

            snapshotPreview
        }
        .padding()
    }

    private var circle: some View {
        Circle()
            .fill(Color.green.opacity(0.6))
            .frame(width: 150, height: 150)
    }

    @ViewBuilder
    private var snapshotPreview: some View {
        if let snapshot {
            snapshot
                .resizable()
                .scaledToFit()
                .frame(height: 120)
        }
    }
}

#Preview {
    CircleSnapshotDemo()
}
