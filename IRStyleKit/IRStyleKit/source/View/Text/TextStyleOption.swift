//
//  TextStyleOption.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 23.05.2025.
//

import SwiftUI

public extension View {
    func anyTextStyle(
        font: Font? = nil,
        weight: Font.Weight? = nil,
        color: Color? = nil
    ) -> some View {
        self
            .font(font)
            .fontWeight(weight)
            .foregroundColor(color)
    }
}

struct TextStylesDemoView: View {
    private let weightOptions: [(name: String, weight: Font.Weight)] = [
        ("UltraLight", .ultraLight),
        ("Thin",       .thin),
        ("Light",      .light),
        ("Regular",    .regular),
        ("Medium",     .medium),
        ("Semibold",   .semibold),
        ("Bold",       .bold),
        ("Heavy",      .heavy),
        ("Black",      .black)
    ]
    
    private let colorOptions: [(name: String, color: Color)] = [
        ("Primary",   .primary),
        ("Secondary", .secondary),
        ("Accent",    .accentColor),
        ("Red",       .red),
        ("Green",     .green),
        ("Blue",      .blue),
        ("Orange",    .orange),
        ("Purple",    .purple),
        ("Pink",      .pink),
        ("Yellow",    .yellow),
        ("Gray",      .gray)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // MARK: Font Styles
                VStack(alignment: .leading, spacing: 8) {
                    Text("Font Styles").font(.title2).fontWeight(.semibold)
                    Group {
                        Text("Large Title").anyTextStyle(font: .largeTitle)
                        Text("Title").anyTextStyle(font: .title)
                        Text("Title 2").anyTextStyle(font: .title2)
                        Text("Title 3").anyTextStyle(font: .title3)
                        Text("Headline").anyTextStyle(font: .headline)
                        Text("Subheadline").anyTextStyle(font: .subheadline)
                        Text("Body").anyTextStyle(font: .body)
                        Text("Callout").anyTextStyle(font: .callout)
                        Text("Caption").anyTextStyle(font: .caption)
                        Text("Caption 2").anyTextStyle(font: .caption2)
                        Text("Footnote").anyTextStyle(font: .footnote)
                    }
                }
                
                // MARK: Weight Variations
                VStack(alignment: .leading, spacing: 8) {
                    Text("Weight Variations").font(.title2).fontWeight(.semibold)
                    ForEach(weightOptions, id: \.name) { option in
                        Text(option.name).anyTextStyle(font: .body, weight: option.weight)
                    }
                }
                
                // MARK: Colour Options
                VStack(alignment: .leading, spacing: 8) {
                    Text("Colour Options").font(.title2).fontWeight(.semibold)
                    ForEach(colorOptions, id: \.name) { option in
                        Text(option.name).anyTextStyle(font: .body, color: option.color)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }
}

struct TextStylesDemoView_Previews: PreviewProvider {
    static var previews: some View {
        TextStylesDemoView()
    }
}
