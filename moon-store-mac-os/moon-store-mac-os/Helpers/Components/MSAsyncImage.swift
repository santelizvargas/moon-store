//
//  MSAsyncImage.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/31/24.
//

import SwiftUI

private enum Constants {
    static let placeholder: String = "questionmark.circle.dashed"
    static let imageSize: CGFloat = 50
    static let spinnerSize: CGFloat = imageSize * 0.5
}

struct MSAsyncImage: View {
    private let url: String
    private let size: CGFloat
    private let placeholder: String
    
    init(url: String,
         size: CGFloat = Constants.imageSize,
         placeHolder: String = Constants.placeholder) {
        self.url = url
        self.size = size
        self.placeholder = placeHolder
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image.resizable()
            } else if phase.error != nil {
                Image(systemName: placeholder)
                    .resizable()
            } else {
                MSSpinner(spinnerSize: Constants.spinnerSize)
            }
        }
        .clipShape(Circle())
        .frame(square: size)
    }
}

#Preview {
    MSAsyncImage(url: Constants.placeholder)
}
