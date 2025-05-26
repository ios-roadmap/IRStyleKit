//
//  HeroCellView.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 26.05.2025.
//

import SwiftUI
internal import IRCommon

public struct HeroCellView: View {
    
    public var title: String?
    public var subtitle: String?
    public var imageName: String?
    
    init(
        title: String? = nil,
        subtitle: String? = nil,
        imageName: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
    }
    
    public var body: some View {
        ZStack {
            if let imageName {
                AsyncImageView(urlString: imageName)
            } else {
                Rectangle()
                    .fill(Color.gray)
            }
        }
        .overlay(alignment: .bottomLeading) {
            VStack(alignment: .leading, spacing: 4) {
                if let title {
                    Text(title)
                        .anyTextStyle(
                            font: .headline, color: .white
                        )
                }
                
                if let subtitle {
                    Text(subtitle)
                        .anyTextStyle(
                            font: .subheadline, color: .white
                        )
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .addingGradientBackgroundForText()
        }
        .cornerRadius(16)
    }
}

#Preview {
    HeroCellView(
        title: "iOS Developer",
        subtitle: "Omer Faruk Ozturk"
    )
    .frame(width: 200, height: 200)
}
