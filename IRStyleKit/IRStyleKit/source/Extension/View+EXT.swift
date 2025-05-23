//
//  View+EXT.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 22.05.2025.
//

import SwiftUI

public extension View {
    
    @ViewBuilder
    func ifStatisfiedCondition(_ condition: Bool, transform: (Self) -> some View) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Adds a nearly invisible background to make the view reliably tappable.
    /// Especially useful for views without padding or visible background,
    /// as fully transparent views (opacity 0.0) are ignored by hit-testing in SwiftUI.
    func tappableBackground() -> some View {
        background(Color.black.opacity(0.01))
    }
}
