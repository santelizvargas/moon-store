//
//  MSEmptyView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/27/24.
//

import SwiftUI

private enum Constants {
    static let cornerRadius: CGFloat = 10
    static let defaultImageSize: CGFloat = 200
    static let mainSpacing: CGFloat = 15
    static let emptyListImage: String = "list.bullet.clipboard"
    static let buttonIcon: String = "repeat"
}

struct MSEmptyListView: View {
    private let retryAction: () -> Void
    private let imageSize: CGFloat
    
    init(imageSize: CGFloat = Constants.defaultImageSize,
         retryAction: @escaping () -> Void) {
        self.imageSize = imageSize
        self.retryAction = retryAction
    }
    
    var body: some View {
        VStack(spacing: Constants.mainSpacing) {
            Image(.msEmpty)
                .resizable()
                .scaledToFit()
                .frame(width: Constants.defaultImageSize)
                .foregroundStyle(.msDarkGray)
            
            Text("No se encontraron elementos")
                .foregroundStyle(.msDarkGray)
            
            Button("Reintentar", systemImage: Constants.buttonIcon) {
                retryAction()
            }
            .buttonStyle(.plain)
            .padding(Constants.cornerRadius)
            .foregroundStyle(.msWhite)
            .background(
                .msPrimary,
                in: .rect(cornerRadius: Constants.cornerRadius)
            )
        }
    }
}

#Preview {
    MSEmptyListView { }
}
