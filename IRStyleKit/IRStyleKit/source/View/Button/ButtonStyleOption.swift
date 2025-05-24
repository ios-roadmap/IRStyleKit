//
//  ButtonStyleOption.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 23.05.2025.
//

import SwiftUI
import IRResources
import IRFoundation

public struct ButtonModel {
    public var name: String
    public var handler: VoidHandler
    
    public init(name: String, handler: @escaping VoidHandler) {
        self.name = name
        self.handler = handler
    }
}

@MainActor
public enum ButtonStyleOption {
    case plain, highlight, press, bounce
}

struct HighlightButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .tappableBackground()
            .overlay {
                configuration.isPressed ? Color.accent.opacity(0.4) : Color.accent.opacity(0)
            }
            .animation(.smooth, value: configuration.isPressed)
            .cornerRadius(6)
    }
}

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .tappableBackground()
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.smooth, value: configuration.isPressed)
            .cornerRadius(6)
    }
}

struct BounceButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.08 : 1)
            .animation(.bouncy(duration: 0.35), value: configuration.isPressed)
            .cornerRadius(6)
    }
}

public extension View {
    
    @ViewBuilder
    func anyButton(
        option: ButtonStyleOption = .plain,
        action: @escaping () -> Void
    ) -> some View {
        switch option {
        case .highlight:
            highlightButton(action: action)
        case .press:
            pressButton(action: action)
        case .bounce:
            bounceButton(action: action)
        default:
            plainButtonStyle(action: action)
        }
    }
    
    private func plainButtonStyle(action: @escaping () -> Void) -> some View {
        Button(action: action) { self }.buttonStyle(.plain)
    }
    
    private func highlightButton(action: @escaping () -> Void) -> some View {
        Button(action: action, label: { self }).buttonStyle(HighlightButtonStyle())
    }
    
    private func pressButton(action: @escaping () -> Void) -> some View {
        Button(action: action, label: { self }).buttonStyle(PressableButtonStyle())
    }
    
    private func bounceButton(action: @escaping () -> Void) -> some View {
        Button(action: action, label: { self }).buttonStyle(BounceButtonStyle())
    }
}

private let samples: [(title: String, colour: Color, option: ButtonStyleOption)] = [
    ("bounce",          .green,   .bounce),
    ("highlight",       .white,    .highlight),
    ("plain",           .accent,  .plain),
    ("press",           .gray,    .press),
]

#Preview("Button styles") {
    ScrollView {
        VStack(spacing: 12) {
            ForEach(samples.indices, id: \.self) { i in
                let s = samples[i]
                Text(s.title)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(s.colour)
                    .anyButton(option: s.option) { print(s.title) }
            }
        }
        .padding()
    }
}

public extension View {
    func callToActionButtonDesign() -> some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.accent)
            .cornerRadius(16)
    }
    
    func underlineTextButtonDesign() -> some View {
        self
            .underline()
            .font(.body)
            .padding(8)
    }
}
