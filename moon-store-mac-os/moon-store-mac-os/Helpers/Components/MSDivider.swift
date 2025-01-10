//
//  MSDivider.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/8/25.
//

import SwiftUI

private enum Constants {
    static let defaultMaxHeight: CGFloat = 1
}

struct MSDivider: View {
    private let color: Color
    private let size: CGFloat
    
    init(color: Color = .msGray,
         size: CGFloat = Constants.defaultMaxHeight) {
        self.color = color
        self.size = size
    }
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(maxWidth: .infinity, maxHeight: size)
    }
}

#Preview {
    MSDivider()
}
