//
//  TabBarView.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 25.05.2025.
//

import SwiftUI

public protocol TabBarRepresentable: Identifiable, Hashable {
    var title: String { get }
    var systemImage: String? { get }
    
    associatedtype Content: View
    @ViewBuilder var content: Content { get }
}

public struct TabBarView<Tab: TabBarRepresentable>: View {
    private let tabs: [Tab]

    public init(tabs: [Tab]) {
        self.tabs = tabs
    }

    public var body: some View {
        TabView {
            ForEach(tabs) { tab in
                tab.content
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage ?? "") //TODO:
                    }
                    .tag(tab.id)
            }
        }
    }
}

enum PreviewTabBarEnum: String, CaseIterable, TabBarRepresentable {
    case explore, chats, profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .explore: return "Explore"
        case .chats:   return "Chats"
        case .profile: return "Profile"
        }
    }

    var systemImage: String? {
        switch self {
        case .explore: return "eyes"
        case .chats:   return "bubble.left.and.bubble.right.fill"
        case .profile: return "person.fill"
        }
    }

    typealias Content = AnyView

    var content: AnyView {
        switch self {
        case .explore: return AnyView(Text("123"))
        case .chats:   return AnyView(Text("456"))
        case .profile: return AnyView(Text("5555"))
        }
    }
}

#Preview(body: {
    TabBarView(tabs: PreviewTabBarEnum.allCases)
})
