//
//  Binding+Extension.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//

import SwiftUI

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
            let filtered = wrappedValue.filter { $0.isNumber || $0 == "." }
            if filtered != wrappedValue {
                wrappedValue = filtered
            }
        }
        return self
    }
}

