//
//  PromoCardView.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 10.05.2025.
//

import SwiftUI

/// A tiny promotional card to demo snapshot testing.
struct PromoCardView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "gift.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .foregroundStyle(.white)
                .padding(24)
                .background(.pink.gradient, in: Circle())

            Text("Spring Sale 25 % OFF")
                .font(.headline)
            
            Text("Use code **SPRING25** at checkout.")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding(24)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(radius: 6)
    }
}


#Preview {
    PromoCardView()
}
