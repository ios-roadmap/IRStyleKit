//
//  String+Ext.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 24.05.2025.
//

import SwiftUI
public import IRResources

public extension String {
    func highlightedAttributedString(
        _ keywords: [String],
        colour: Color = Color.accent,
        weight: Font.Weight = .semibold
    ) -> AttributedString {
        let baseSize = UIFont.preferredFont(forTextStyle: .title3).pointSize
        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(colour),
            .font: UIFont.systemFont(ofSize: baseSize, weight: .init(weight))
        ]
        
        let source  = self as NSString
        let mutable = NSMutableAttributedString(string: self)
        
        for word in keywords {
            var search = NSRange(location: 0, length: source.length)
            
            while true {
                let hit = source.range(of: word,
                                       options: [.caseInsensitive],
                                       range: search)
                guard hit.location != NSNotFound else { break }
                mutable.addAttributes(attrs, range: hit)
                
                let next = hit.location + hit.length
                search   = NSRange(location: next, length: source.length - next)
            }
        }
        return AttributedString(mutable)
    }
}

// TODO: Ayrı bir modifier olmalı!
