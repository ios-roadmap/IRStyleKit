//
//  Tag.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 25.05.2025.
//

import SwiftUI

public extension View {
    func badgeText() -> some View {
        self
            .font(.caption)
            .bold()
            .foregroundStyle(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color.blue)
            .cornerRadius(6)
    }
}
