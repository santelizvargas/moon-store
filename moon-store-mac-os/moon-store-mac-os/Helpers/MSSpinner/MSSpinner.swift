//
//  MSSpinner.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/27/24.
//

import SwiftUI

private enum Constants {
    static let strokeLineWidth: CGFloat = 10
    static let spinnerSize: CGFloat = 50
    static let animationDuration: CGFloat = 1
    static let rotationDegrees: CGFloat = 360
}

struct MSSpinner: View {
    @State private var rotation: Double = .zero
    
    private let spinnerSize: CGFloat
    
    init(spinnerSize: CGFloat = Constants.spinnerSize) {
        self.spinnerSize = spinnerSize
    }
    
    var body: some View {
        Circle()
            .stroke(
                AngularGradient(
                    colors: [.clear, .msPrimary],
                    center: .center
                ),
                lineWidth: Constants.strokeLineWidth
            )
            .frame(square: spinnerSize)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                withAnimation(
                    .linear(duration: Constants.animationDuration)
                    .repeatForever(autoreverses: false)
                ) {
                    rotation = Constants.rotationDegrees
                }
            }
    }
}
