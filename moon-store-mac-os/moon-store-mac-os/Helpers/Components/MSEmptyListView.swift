//
//  MSEmptyView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/27/24.
//

import SwiftUI

private enum Constants {
    static let cornerRadius: CGFloat = 10
    static let imageSize: CGFloat = 200
    static let imageHeight: CGFloat = imageSize * 0.7
    static let emptyListImage: String = "list.bullet.clipboard"
    static let buttonIcon: String = "repeat"
}

struct MSEmptyListView: View {
    private let retryAction: () -> Void
    private let imageSize: CGFloat
    
    init(imageSize: CGFloat = Constants.imageSize,
         retryAction: @escaping () -> Void) {
        self.imageSize = imageSize
        self.retryAction = retryAction
    }
    
    var body: some View {
        VStack {
            Image(.msEmpty)
                .resizable()
                .frame(width: Constants.imageSize,
                       height: Constants.imageHeight)
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
                in: .rect(cornerRadius: Constants.cornerRadius))
        }
    }
}

#Preview {
    MSEmptyListView { }
}
