//
//  Text.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 26.05.2025.
//

import SwiftUI

public extension View {
    func addingGradientBackgroundForText() -> some View {
        self
            .background(
                LinearGradient(
                    colors: [
                        Color.black.opacity(0),
                        Color.black.opacity(0.3),
                        Color.black.opacity(0.4)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}
