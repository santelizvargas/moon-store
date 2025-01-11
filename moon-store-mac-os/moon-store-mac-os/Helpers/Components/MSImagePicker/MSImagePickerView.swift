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
            loadedImage
                .frame(maxSquare: Constants.imageSize)
            
            PhotosPicker(
                "Seleccionar imagen",
                selection: $selectedItem,
                matching: .images
            )
            .foregroundStyle(.msPrimary)
            .task(id: selectedItem) {
                guard let image = await viewModel.loadImage(from: selectedItem) else { return }
                selectedImage = image
            }
        }
    }
    
    @ViewBuilder
    private var loadedImage: some View {
        if let image = selectedImage {
            image
                .resizable()
                .scaledToFit()
                .clipShape(.rect(cornerRadius: Constants.cornerRadius))
        } else {
            Image(systemName: "photo.artframe")
                .resizable()
                .foregroundStyle(.gray)
        }
    }
}
