//
//  MediaTileView.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 26.05.2025.
//

import SwiftUI
internal import IRCommon

public struct MediaTileView: View {
    
    public var title: String
    public var imageName: String?
    
    init(
        title: String,
        imageName: String?
    ) {
        self.title = title
        self.imageName = imageName
    }
    
    public var body: some View {
        ZStack {
            if let imageName {
                AsyncImageView(urlString: imageName)
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.gray)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .overlay(alignment: .bottomLeading) {
            Text(title)
                .anyTextStyle(
                    font: .body,
                    weight: .semibold,
                    color: .white
                )
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .addingGradientBackgroundForText()
        }
        .cornerRadius(16)
    }
}

#Preview {
    MediaTileView(
        title: "iOS Developer",
        imageName: Constants.randomImage
    )
    .frame(width: 150)
}
