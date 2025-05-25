//
//  AsyncImageView.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 22.05.2025.
//

import SwiftUI
internal import IRCommon
internal import SDWebImageSwiftUI

public struct AsyncImageView: View {
    public var urlString: String
    public var forceTransitionAnimation: Bool
    
    public init(
        urlString: String,
        forceTransitionAnimation: Bool = false
    ) {
        self.urlString = urlString
        self.forceTransitionAnimation = forceTransitionAnimation
    }
    
    public var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                WebImage(url: .init(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: .fill)
                    .allowsHitTesting(false)
            }
            .clipped()
            .ifStatisfiedCondition(forceTransitionAnimation, transform: { content in
                content
                    .drawingGroup()
            })
    }
}

#Preview {
    AsyncImageView(urlString: Constants.randomImage)
        .frame(width: 400, height: 400)
}
