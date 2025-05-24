//
//  UIFont+Ext.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 24.05.2025.
//

import SwiftUI

extension UIFont.Weight {
    init(_ swiftUI: Font.Weight) {
        switch swiftUI {
        case .ultraLight: self = .ultraLight
        case .thin:       self = .thin
        case .light:      self = .light
        case .regular:    self = .regular
        case .medium:     self = .medium
        case .semibold:   self = .semibold
        case .bold:       self = .bold
        case .heavy:      self = .heavy
        case .black:      self = .black
        default:          self = .regular
        }
    }
}
