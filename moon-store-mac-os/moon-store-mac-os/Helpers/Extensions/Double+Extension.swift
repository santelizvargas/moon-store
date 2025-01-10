//
//  Double+Extension.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/9/25.
//

private enum Constants {
    static let doubleDividerFormat: Double = 1
    static let integerFormat: String = "%.0f"
    static let decimalFormat: String = "%.2f"
}

extension Double {
    var numberFormatted: String {
        let isZero: Bool = self.truncatingRemainder(dividingBy: Constants.doubleDividerFormat) == .zero
        let format: String = isZero ? Constants.integerFormat : Constants.decimalFormat
        return String(format: format, self)
    }
}
