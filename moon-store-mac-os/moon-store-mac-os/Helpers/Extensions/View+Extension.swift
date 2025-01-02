//
//  View+Extension.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/27/24.
//

import SwiftUI

extension View {
    /// Expands the view to fill available width, aligning content to the leading edge.
    func leadingInfinity() -> some View {
        frame(maxWidth: .infinity, alignment: .leading)
    }
    
    /// Sets both width and height of the view to the same value, creating a square frame.
    func frame(square: CGFloat) -> some View {
        frame(width: square, height: square)
    }
    
    /// Sets the maximum width and height of the view to the same value, creating a square frame.
    func frame(maxSquare: CGFloat) -> some View {
        frame(maxWidth: maxSquare, maxHeight: maxSquare)
    }
    
    /// Adds a spinner overlay to the view based on the provided binding.
    func showSpinner(_ isLoading: Binding<Bool>) -> some View {
        modifier(SpinnerModifier(showSpinner: isLoading))
    }
}
