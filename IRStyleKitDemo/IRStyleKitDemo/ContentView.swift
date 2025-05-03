//
//  ContentView.swift
//  IRStyleKitDemo
//
//  Created by Ömer Faruk Öztürk on 3.05.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Text("Welcome to IRStyleKit")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top, 8)

            VStack(spacing: 16) {
                Button(action: {
                    // SwiftUI view açılabilir burada
                }) {
                    Text("SwiftUI")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }

                Button(action: {
                    openUIKitView()
                }) {
                    Text("UIKit")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray5))
                        .foregroundColor(.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
            }
            .padding(.horizontal, 32)

            Spacer()
        }
        .padding()
    }

    private func openUIKitView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }

        let uiKitVC = ShowcaseListViewController()
        let nav = UINavigationController(rootViewController: uiKitVC)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}

#Preview {
    ContentView()
}
