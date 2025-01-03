//
//  MSImagePickerView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//

import SwiftUI
import _PhotosUI_SwiftUI

private enum Constants {
    static let imageSize: CGFloat = 200
    static let cornerRadius: CGFloat = 6
    static let strokeLineWidth: CGFloat = 2
}

struct MSImagePickerView: View {
    @StateObject private var viewModel: MSImagePickerViewModel = .init()
    
    @Binding private var selectedImage: Image?
    
    init(selectedImage: Binding<Image?>) {
        _selectedImage = selectedImage
    }
    
    var body: some View {
        VStack {
            PhotosPicker(
                "Seleccionar imagen",
                selection: $viewModel.selectedItem,
                matching: .images
            )
            .buttonStyle(.borderedProminent)
            .foregroundStyle(.msPrimary)
            .onChange(of: viewModel.selectedItem) {
                handleImageSelection()
            }
            
            loadedImage
                .frame(maxSquare: Constants.imageSize)
        }
    }
    
    @ViewBuilder
    private var loadedImage: some View {
        let rectangleBackground = RoundedRectangle(cornerRadius: Constants.cornerRadius)
        
        if let image = viewModel.selectedImage {
            image
                .resizable()
                .scaledToFit()
                .clipShape(rectangleBackground)
        } else {
            rectangleBackground
                .stroke(lineWidth: Constants.strokeLineWidth)
        }
    }
    
    private func handleImageSelection() {
        viewModel.loadImage()
        selectedImage = viewModel.selectedImage
    }
}
