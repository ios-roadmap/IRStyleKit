//
//  CarouselView.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 26.05.2025.
//

import SwiftUI
internal import IRCommon

struct CarouselView<Content: View, T: Hashable>: View {
    
    var items: [T]
    @State private var selection: T? = nil
    @ViewBuilder var content: (T) -> Content
    
    var body: some View {
        VStack(spacing: 12) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        content(item)
                            .scrollTransition(
                                .interactive.threshold(.visible(0.95)),
                                axis: .horizontal,
                                transition: { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1 : 0.9)
                                }
                            )
                            .containerRelativeFrame(.horizontal, alignment: .center)
                            .id(item)
                            .onChange(of: items.count, { oldValue, newValue in
                                updateSelectionIfNeeded()
                            })
                            .onAppear {
                                updateSelectionIfNeeded()
                            }
                    }
                }
            }
            .frame(height: 200)
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $selection)
            
            HStack(spacing: 8) {
                ForEach(items, id: \.self) { item in
                    Circle()
                        .fill(item == selection ? Color.accent : .gray)
                        .frame(width: 8, height: 8)
                }
            }
            .animation(.linear, value: selection)
        }
    }
    
    private func updateSelectionIfNeeded() {
        if selection == nil || selection == items.last {
            selection = items.first
        }
    }
}


private struct MockHeroModel: Identifiable, Hashable {
    let id: Int = UUID().hashValue
    let title: String
    let subtitle: String
    let imageName: String
}

private let mockModels: [MockHeroModel] = [
    .init(title: "iOS Developer", subtitle: "Omer Faruk Ozturk", imageName: Constants.randomImage),
    .init(title: "AI Specialist", subtitle: "Jane Doe", imageName: Constants.randomImage),
    .init(title: "UX Designer", subtitle: "John Smith", imageName: Constants.randomImage)
]

#Preview {
    CarouselView(items: mockModels) { item in
        HeroCellView(
            title: item.title,
            subtitle: item.subtitle,
            imageName: item.imageName
        )
    }
    .padding()
}

