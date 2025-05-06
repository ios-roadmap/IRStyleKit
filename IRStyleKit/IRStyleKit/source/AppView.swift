//
//  AppView.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 4.05.2025.
//

import SwiftUI

public struct AppView: View {
    
    @AppStorage("showTabbarView") var showTabBar: Bool = false
    
    public init(showTabBar: Bool = false) {
        self.showTabBar = showTabBar
    }
    
    public var body: some View {
        AppViewBuilder(
            showTabBar: showTabBar,
            tabbarView: {
                ZStack {
                    Color.red.ignoresSafeArea()
                    Text("Tabbar")
                }
            },
            onboardingView: {
                ZStack {
                    Color.blue.ignoresSafeArea()
                    Text("Onboarding")
                }
            }
        )
    }
}

#Preview("AppView - Tabbar") {
    AppView(showTabBar: true)
}

#Preview("AppView - Onboarding") {
    AppView(showTabBar: false)
}
