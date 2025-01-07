//
//  String+Email.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/6/25.
//

private enum Constants {
    static let emailRegex: String = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
}

extension String {
    var matchesEmail: Bool {
        guard let range = range(of: Constants.emailRegex,
                                     options: .regularExpression) else { return false }
        return range.lowerBound == startIndex && range.upperBound == endIndex
    }
}
