//
//  ConfigurableKeyValueView.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 25.05.2025.
//

import SwiftUI
internal import IRCommon

struct ConfigurableKeyValueView: View {
    
    var imageName: String?
    var headline: String? = "iOS Developer"
    var subheadline: String? = "Omer Faruk Ozturk"
    var hasNewTag: Bool = false
    var isCircleImage: Bool = false
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                if let imageName {
                    AsyncImageView(urlString: imageName)
                } else {
                    Rectangle()
                        .fill(
                            .secondary.opacity(0.5)
                        )
                }
            }
            .frame(width: 60, height: 60)
            .clipped(isCircle: isCircleImage, cornerRadius: 16)
            
            VStack(alignment: .leading, spacing: 4) {
                if let headline {
                    Text(headline)
                        .anyTextStyle(
                            font: .headline
                        )
                }
                
                if let subheadline {
                    Text(subheadline)
                        .anyTextStyle(
                            font: .subheadline,
                            color: .secondary
                        )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if hasNewTag {
                Text("NEW")
                    .badgeText()
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(
            Color(uiColor: .systemBackground)
        )
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.3).ignoresSafeArea()
        
        VStack {
            ConfigurableKeyValueView(
                imageName: Constants.randomImage,
                headline: "iOS Developer",
                subheadline: "Omer Faruk Ozturk",
                hasNewTag: true,
                isCircleImage: false
            )
            
            ConfigurableKeyValueView(
                imageName: Constants.randomImage,
                headline: "iOS Developer",
                subheadline: "Omer Faruk Ozturk",
                hasNewTag: false,
                isCircleImage: false
            )
            
            ConfigurableKeyValueView(
                imageName: Constants.randomImage,
                headline: "iOS Developer",
                subheadline: "Omer Faruk Ozturk",
                hasNewTag: false,
                isCircleImage: true
            )
            
            ConfigurableKeyValueView(
                imageName: Constants.randomImage,
                headline: "iOS Developer",
                hasNewTag: false,
                isCircleImage: false
            )
            
            ConfigurableKeyValueView(
                imageName: Constants.randomImage,
                subheadline: "Omer Faruk Ozturk",
                hasNewTag: false,
                isCircleImage: false
            )
            
            ConfigurableKeyValueView(
                headline: "iOS Developer",
                subheadline: "Omer Faruk Ozturk",
                hasNewTag: false,
                isCircleImage: false
            )
        }
    }
}
