//
//  MSAsyncImage.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/31/24.
//

import SwiftUI

enum ShapeType {
    case circle
    case rectangle
}

private enum Constants {
    static let placeholder: String = "questionmark.circle.dashed"
    static let imageSize: CGFloat = 50
    static let spinnerSize: CGFloat = imageSize * 0.5
    static let shapeCornerRadius: CGFloat = 25
}

struct MSAsyncImage: View {
    private let url: String
    private let size: CGFloat
    private let placeholder: String
    private let shape: ShapeType
    
    init(url: String,
         size: CGFloat = Constants.imageSize,
         placeHolder: String = Constants.placeholder,
         shape: ShapeType = .circle) {
        self.url = url
        self.size = size
        self.placeholder = placeHolder
        self.shape = shape
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
        .frame(square: size)
        .background(.clear, in: .rect(cornerRadius: cornerSize))
    }
    
    private var cornerSize: CGFloat {
        switch shape {
            case .circle: size
            case .rectangle: Constants.shapeCornerRadius
        }
    }
}

#Preview {
    MSAsyncImage(url: Constants.placeholder)
}
