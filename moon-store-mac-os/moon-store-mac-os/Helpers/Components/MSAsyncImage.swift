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
    private let imageCache: MemoryCache<String, Image> = .init()
    
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
        AsyncImage(url: URL(string: url)) { image in
            if let cachedImage = saveImage(image) {
                cachedImage
                    .resizable()
            }
        } placeholder: {
            Image(systemName: Constants.placeholder)
                .resizable()
        }
        .frame(square: size)
        .clipShape(RoundedRectangle(cornerRadius: cornerSize))
    }
    
    private var cornerSize: CGFloat {
        switch shape {
            case .circle: size
            case .rectangle: Constants.shapeCornerRadius
        }
    }
    
    private func saveImage(_ image: Image) -> Image? {
        imageCache[url] = image
        return imageCache[url]
    }
}

#Preview {
    MSAsyncImage(url: Constants.placeholder)
}
