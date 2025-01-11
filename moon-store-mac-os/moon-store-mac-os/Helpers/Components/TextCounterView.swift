//
//  TextCounterView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/11/25.
//

import SwiftUI

private enum Constants {
    static let viewHeight: CGFloat = 30
    static let defaultCounter: Int = 10
}

struct TextCounterView: View {
    private let counter: Int
    
    init(_ counter: Int) {
        self.counter = counter
    }
    
    var body: some View {
        Text(localized(.textTitle))
            .frame(height: Constants.viewHeight)
            .padding(.horizontal)
            .background(.msWhite, in: .capsule)
            .foregroundStyle(.msBlack)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
    }
}

// MARK: - Localized

extension TextCounterView {
    private enum LocalizedKey {
        case textTitle
    }
    
    private func localized(_ key: LocalizedKey) -> String {
        switch key {
            case .textTitle: "Total: \(counter)"
        }
    }
}

#Preview {
    TextCounterView(Constants.defaultCounter)
}
