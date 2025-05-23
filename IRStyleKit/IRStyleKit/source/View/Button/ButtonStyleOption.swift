//
//  ButtonStyleOption.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 23.05.2025.
//

import SwiftUI
internal import IRResources

@MainActor
public enum ButtonStyleOption {
    public enum Rotate {
        case subtle, flip, wobble, spin, twist, magnet
    }
    
    case plain, highlight, press, bounce, glow, ripple
    case rotate(Rotate)
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

struct GlowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .tappableBackground()
            .shadow(color: .accent.opacity(configuration.isPressed ? 0.8 : 0.0),
                    radius: 10, y: 0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .cornerRadius(6)
    }
}

struct RippleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .tappableBackground()
            .overlay {
                if configuration.isPressed {
                    Circle()
                        .fill(Color.accent.opacity(0.25))
                        .scaleEffect(1.6)
                        .animation(.easeOut(duration: 0.4), value: configuration.isPressed)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

struct SubtleRotateButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .tappableBackground()
            .rotationEffect(.degrees(configuration.isPressed ? 3 : 0))
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
            .cornerRadius(6)
    }
}

struct FlipButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .tappableBackground()
            .rotation3DEffect(.degrees(configuration.isPressed ? 180 : 0),
                              axis: (0, 1, 0))
            .animation(.easeInOut(duration: 0.4), value: configuration.isPressed)
    }
}

struct WobbleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .tappableBackground()
            .rotationEffect(.degrees(configuration.isPressed ? 8 : 0))
            .animation(.interpolatingSpring(stiffness: 120, damping: 5), value: configuration.isPressed)
    }
}

struct SpinButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .tappableBackground()
            .rotationEffect(.degrees(configuration.isPressed ? 360 : 0))
            .animation(.easeInOut(duration: 0.5), value: configuration.isPressed)
    }
}

struct TwistTiltButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .tappableBackground()
            .rotation3DEffect(.degrees(configuration.isPressed ? 20 : 0),
                              axis: (1, 1, 0))
            .animation(.spring(response: 0.4, dampingFraction: 0.5), value: configuration.isPressed)
    }
}

struct MagnetButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .tappableBackground()
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .rotationEffect(.degrees(configuration.isPressed ? -5 : 0))
            .animation(.spring(response: 0.2, dampingFraction: 0.5), value: configuration.isPressed)
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
            pressableButton(action: action)
        case .bounce:
            bounceButton(action: action)
        case .glow:
            glowButton(action: action)
        case .ripple:
            rippleButton(action: action)
        case .rotate(.subtle):
            subtleRotateButton(action: action)
        case .rotate(.flip):
            flipRotateButton(action: action)
        case .rotate(.spin):
            spinRotateButton(action: action)
        case .rotate(.twist):
            twistRotateButton(action: action)
        case .rotate(.magnet):
            magnetRotateButton(action: action)
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
    
    private func pressableButton(action: @escaping () -> Void) -> some View {
        Button(action: action, label: { self }).buttonStyle(PressableButtonStyle())
    }
    
    private func bounceButton(action: @escaping () -> Void) -> some View {
        Button(action: action, label: { self }).buttonStyle(BounceButtonStyle())
    }
    
    private func glowButton(action: @escaping () -> Void) -> some View {
        Button(action: action, label: { self }).buttonStyle(GlowButtonStyle())
    }
    
    private func rippleButton(action: @escaping () -> Void) -> some View {
        Button(action: action, label: { self }).buttonStyle(RippleButtonStyle())
    }
    
    private func subtleRotateButton(action: @escaping () -> Void) -> some View {
        Button(action: action, label: { self }).buttonStyle(SubtleRotateButtonStyle())
    }
    
    private func flipRotateButton(action: @escaping () -> Void) -> some View {
        Button(action: action, label: { self }).buttonStyle(FlipButtonStyle())
    }
    
    private func spinRotateButton(action: @escaping () -> Void) -> some View {
        Button(action: action, label: { self }).buttonStyle(SpinButtonStyle())
    }
    
    private func twistRotateButton(action: @escaping () -> Void) -> some View {
        Button(action: action, label: { self }).buttonStyle(TwistTiltButtonStyle())
    }
    
    private func magnetRotateButton(action: @escaping () -> Void) -> some View {
        Button(action: action, label: { self }).buttonStyle(MagnetButtonStyle())
    }
}

private let samples: [(title: String, colour: Color, option: ButtonStyleOption)] = [
    ("bounce",          .green,   .bounce),
    ("glow",            .white,  .glow),
    ("highlight",       .white,    .highlight),
    ("plain",           .accent,  .plain),
    ("press",           .gray,    .press),
    ("ripple",          .pink,    .ripple),
    ("rotate.subtle",   .purple,  .rotate(.subtle)),
    ("rotate.flip",     .purple,  .rotate(.flip)),
    ("rotate.spin",     .purple,  .rotate(.spin)),
    ("rotate.twist",    .purple,  .rotate(.twist)),
    ("rotate.magnet",   .purple,  .rotate(.magnet)),
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
                    .tappableBackground()
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
