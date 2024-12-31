//
//  MSSpinner.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/27/24.
//

import SwiftUI

private enum Constants {
    static let backgroundOpacity: CGFloat = 0.2
    static let strokeLineWidth: CGFloat = 10
    static let colors: [Color] = [.clear, .msPrimary]
    static let spinnerSize: CGFloat = 50
    static let animationDuration: CGFloat = 1
    static let rotationDegrees: CGFloat = 360
}

struct MSSpinner: View {
    @State private var rotation: Double = .zero
    
    var body: some View {
        Circle()
            .stroke(
                AngularGradient(gradient: Gradient(colors: Constants.colors),
                                center: .center),
                style: StrokeStyle(lineWidth: Constants.strokeLineWidth)
            )
            .frame(width: Constants.spinnerSize,
                   height: Constants.spinnerSize)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                withAnimation(
                    .linear(duration: Constants.animationDuration)
                    .repeatForever(autoreverses: false)
                ) { rotation = Constants.rotationDegrees }
            }
    }
}

#Preview {
    MSSpinner()
}
