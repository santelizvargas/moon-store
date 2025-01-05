//
//  Date+String.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 3/1/25.
//

import Foundation

private enum Constants {
    static let dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let eSIdentifier: String = "es_ES"
    static let uSIdentifier: String = "en_US_POSIX"
    static let spanishFormat: String = "MMMM d yyyy"
}

extension String {
    /// Formats an ISO 8601 date string (`yyyy-MM-dd'T'HH:mm:ss.SSSZ`)
    /// into a readable Spanish format (`MMMM d yyyy`).
    /// Returns "Fecha inválida" if the input is not a valid date.
    var formattedDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        dateFormatter.locale = Locale(identifier: Constants.uSIdentifier)
        
        guard let date = dateFormatter.date(from: self) else { return nil }
        dateFormatter.dateFormat = Constants.spanishFormat
        dateFormatter.locale = Locale(identifier: Constants.eSIdentifier)
        
        let stringFormattedDate = dateFormatter.string(from: date)
        return stringFormattedDate.capitalized
    }
}
