//
//  ColorGridView.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 24.05.2025.
//

import SwiftUI
import IRResources

/// GridItem(.fixed(80))       // Her hücre 80pt genişlikte
/// GridItem(.flexible())      // Ekran boyutuna göre esneyebilir
/// GridItem(.adaptive(minimum: 80)) // En az 80pt olacak şekilde olabildiğince çok hücre sığdır

public struct ColorGridView: View {

    public let selectorColor: Color
    @Binding public var selectedColor: Color?        // optional wrapped value
    public let colors: [Color]

    public init(
        selectorColor: Color = .accent,
        selectedColor: Binding<Color?>,
        colors: [Color]
    ) {
        self.selectorColor = selectorColor
        self._selectedColor = selectedColor
        self.colors = colors
    }

    public var body: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3),
            spacing: 16
        ) {
            Section(header: header) {
                ForEach(colors, id: \.self, content: colorCircle)
            }
        }
        .animation(.easeInOut, value: selectedColor)
    }

    private var header: some View {
        Text("Select a profile colour")
            .font(.headline)
    }

    private func colorCircle(_ colour: Color) -> some View {
        Circle()
            .fill(selectedColor == colour ? selectorColor : .clear)
            .overlay(
                Circle()
                    .fill(colour)
                    .padding(selectedColor == colour ? 8 : 0)
            )
            .onTapGesture {
                selectedColor = (selectedColor == colour) ? nil : colour   // tap to toggle
            }
    }
}

private struct ContentView: View {
    @State private var selectedColor: Color? = .blue
    private let allColors: [Color] = [
        .red, .green, .orange, .blue, .mint, .purple, .cyan, .teal, .indigo
    ]
    
    var body: some View {
        ColorGridView(
            selectedColor: $selectedColor,
            colors: allColors
        )
    }
}

#Preview(body: {
    ContentView()
})
