//
//  MSLogo.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/12/25.
//

import SwiftUI

private enum Constants {
    static let defaultWidth: CGFloat = 200
    static let heightPercentage: CGFloat = 0.9
}

struct MSLogo: View {
    private let size: CGFloat
    
    init(size: CGFloat = Constants.defaultWidth) {
        self.size = size
    }
    
    var body: some View {
        Image(.msLogo)
            .resizable()
            .frame(width: size,
                   height: size * Constants.heightPercentage)
    }
}

#Preview {
    MSLogo()
}
