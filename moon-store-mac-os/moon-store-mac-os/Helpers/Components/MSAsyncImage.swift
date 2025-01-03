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
    static let spinnerSize: CGFloat = imageSize * 0.8
    static let shapeCornerRadius: CGFloat = 6
    static let animationDuration: CGFloat = 2
}

struct MSAsyncImage: View {
    private let url: String
    private let size: CGFloat
    private let placeholder: String
    private let shape: ShapeType
    private let imageCache: ImageCache = .shared
    
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
        asyncImage
            .frame(square: size)
            .clipShape(.rect(cornerRadius: cornerSize))
    }
    
    @ViewBuilder
    private var asyncImage: some View {
        if let cachedImage = imageCache.getImage(from: url) {
            cachedImage
                .resizable()
        } else {
            AsyncImage(url: URL(string: url)) { image in
                imageCache.addImage(image, with: url)
                    .resizable()
            } placeholder: {
                Image(systemName: Constants.placeholder)
                    .resizable()
            }
        }
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
