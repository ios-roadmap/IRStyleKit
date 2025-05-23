//
//  PolicyLinksView.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 23.05.2025.
//

import SwiftUI

public struct PolicyLinksView: View {
    let termsURLString: String?
    let privacyURLString: String?

    public init(
        termsURLString: String? = nil,
        privacyURLString: String? = nil
    ) {
        self.termsURLString = termsURLString
        self.privacyURLString = privacyURLString
    }

    public var body: some View {
        HStack(spacing: 8) {
            if let termsURLString {
                Link(destination: .init(string: termsURLString)!) {
                    Text("Terms of Service")
                }
            }

            if termsURLString != nil && privacyURLString != nil {
                Circle()
                    .fill(Color.accent)
                    .frame(width: 4, height: 4)
            }

            if let privacyURLString {
                Link(destination: .init(string: privacyURLString)!) {
                    Text("Privacy Policy")
                }
            }
        }
    }
}

#Preview {
    PolicyLinksView(
        termsURLString: "https://google.com",
        privacyURLString: "https://google.com/privacy"
    )
}
