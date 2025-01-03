//
//  Date+String.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 3/1/25.
//

import Foundation

extension String {
    /// Formats an ISO 8601 date string (`yyyy-MM-dd'T'HH:mm:ss.SSSZ`)
    /// into a readable Spanish format (`MMMM d yyyy`).
    /// Returns "Fecha inválida" if the input is not a valid date.
    var formattedDate: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMMM d yyyy"
            outputFormatter.locale = Locale(identifier: "es_ES")
            
            return outputFormatter.string(from: date).capitalized
        }
        
        return "Fecha inválida"
    }
}
