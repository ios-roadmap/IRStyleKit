//
//  CustomizableButton.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 25.05.2025.
//

import SwiftUI
import IRFoundation

public struct CustomizableButton: View {
    var isLoading: Bool
    var name: String
    var style: ButtonStyleOption
    var handler: VoidHandler
    
    public init(
        isLoading: Bool = false,
        name: String,
        style: ButtonStyleOption = .plain,
        handler: @escaping VoidHandler
    ) {
        self.isLoading = isLoading
        self.name = name
        self.style = style
        self.handler = handler
    }
    
    public var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Text(name)
            }
        }
        .callToActionButtonDesign()
        .anyButton(option: style, action: handler)
        .disabled(isLoading)
    }
}

private struct PreviewView: View {
    @State private var isLoading: Bool = false
    
    var body: some View {
        CustomizableButton(
            isLoading: isLoading,
            name: "Finish",
            style: .plain,
            handler: {
                isLoading = true
                
                Task {
                    try? await Task.sleep(for: .seconds(1)) //TODO: ayrı extension olmalı.
                    isLoading = false
                }
            }
        )
        .padding(.horizontal)
    }
}

#Preview {
    PreviewView()
}
