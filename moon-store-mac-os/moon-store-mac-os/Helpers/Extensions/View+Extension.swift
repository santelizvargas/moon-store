//
//  View+Extension.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/27/24.
//

import SwiftUI

extension View {
    func leadingInfinity() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
}
