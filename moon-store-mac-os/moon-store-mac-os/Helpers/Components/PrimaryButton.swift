//
//  PrimaryButton.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 18/11/24.
//

import SwiftUI

private enum Constants {
    static let maxHeight: CGFloat = 40
    static let cornerRadius: CGFloat = 6
}

struct PrimaryButton: View {
    private let title: String
    private let action: () -> Void
    
    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button(title) {
            withAnimation { action() }
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity, maxHeight: Constants.maxHeight)
        .foregroundStyle(.msWhite)
        .background(.msPrimary, in: .rect(cornerRadius: Constants.cornerRadius))
    }
}
