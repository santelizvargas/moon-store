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
            .task(id: viewModel.selectedItem) {
                guard let image = await viewModel.loadImage() else { return }
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
