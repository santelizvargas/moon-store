//
//  MSEmptyView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/27/24.
//

import SwiftUI

private enum Constants {
    static let cornerRadius: CGFloat = 10
    static let imageWidth: CGFloat = 80
    static let imageHeight: CGFloat = 100
    static let emptyListImage: String = "list.bullet.clipboard"
    static let buttonIcon: String = "repeat"
}

struct MSEmptyListView: View {
    private let retryAction: () -> Void
    
    init(retryAction: @escaping () -> Void) {
        self.retryAction = retryAction
    }
    
    var body: some View {
        VStack {
            Image(systemName: Constants.emptyListImage)
                .resizable()
                .frame(width: Constants.imageWidth,
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
