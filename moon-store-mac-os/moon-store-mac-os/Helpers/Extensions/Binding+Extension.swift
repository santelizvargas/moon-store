//
//  Binding+Extension.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//

import SwiftUI

private enum Constants {
    static let decimalNumbersRegex: String = "^[0-9]*\\.?[0-9]*$"
}

extension Binding where Value == String {
    var allowOnlyNumbers: Self {
        DispatchQueue.main.async {
            let filtered = wrappedValue.filter { $0.isNumber }
            if filtered != wrappedValue {
                wrappedValue = filtered
            }
        }
        return self
    }
    
    var allowOnlyDecimalNumbers: Self {
        DispatchQueue.main.async {
            if let match = wrappedValue.range(of: Constants.decimalNumbersRegex,
                                              options: .regularExpression) {
                wrappedValue = String(wrappedValue[match])
            } else if wrappedValue.last == "." || wrappedValue.last == " " {
                wrappedValue.removeLast()
            }
        }
        
        return self
    }
}
