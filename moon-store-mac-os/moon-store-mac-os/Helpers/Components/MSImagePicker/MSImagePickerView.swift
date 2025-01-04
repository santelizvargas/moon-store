//
//  MSImagePickerView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//

import SwiftUI
import PhotosUI

private enum Constants {
    static let imageSize: CGFloat = 200
    static let cornerRadius: CGFloat = 6
    static let strokeLineWidth: CGFloat = 2
}

struct MSImagePickerView: View {
    @Binding private var selectedImage: Image?
    @State private var selectedItem: PhotosPickerItem?
    
    private let viewModel: MSImagePickerUtility = .init()
    
    init(selectedImage: Binding<Image?>) {
        _selectedImage = selectedImage
    }
    
    var body: some View {
        VStack {
            PhotosPicker(
                "Seleccionar imagen",
                selection: $selectedItem,
                matching: .images
            )
            .buttonStyle(.borderedProminent)
            .foregroundStyle(.msPrimary)
            .task(id: selectedItem) {
                guard let image = await viewModel.loadImage(from: selectedItem) else { return }
                selectedImage = image
            }
            
            loadedImage
                .frame(maxSquare: Constants.imageSize)
                .foregroundStyle(.msPrimary)
        }
    }
    
    @ViewBuilder
    private var loadedImage: some View {
        let rectangleBackground = RoundedRectangle(cornerRadius: Constants.cornerRadius)
        
        if let image = selectedImage {
            image
                .resizable()
                .scaledToFit()
                .clipShape(rectangleBackground)
        } else {
            rectangleBackground
                .stroke(lineWidth: Constants.strokeLineWidth)
        }
    }
}
