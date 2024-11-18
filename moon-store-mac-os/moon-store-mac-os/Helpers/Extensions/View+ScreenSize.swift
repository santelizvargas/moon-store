//
//  View+ScreenSize.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 17/11/24.
//

import SwiftUI

private enum Constants {
    static let minWidth: CGFloat = 600
    static let minHeight: CGFloat = 400
}

extension View {
    func minScreenSize() -> some View {
        frame(
            minWidth: Constants.minWidth,
            minHeight: Constants.minHeight
        )
    }
}
