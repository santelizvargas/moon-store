//
//  Screen.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 17/11/24.
//

enum Screen: String, Identifiable, CaseIterable {
    case first, second, third

    var id: String { rawValue }
    
    var title: String { rawValue.capitalized }
}
