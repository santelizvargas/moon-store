//
//  AddProductViewModel+Edit.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//

import SwiftUI
import _PhotosUI_SwiftUI

@MainActor
final class AddProductViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var name: String = ""
    @Published var price: String = ""
    @Published var stock: String = ""
    @Published var description: String = ""
    @Published var category: ProductCategory = .laptop
    
    @Published var imageSelected: Image? {
        didSet {
            loadImageData()
        }
    }
    
    var canCreateProduct: Bool {
        name.isEmpty ||
        price.isEmpty ||
        description.isEmpty ||
        stock.isEmpty
    }
    
    private var imageData: Data?
    
    private let productManager: ProductManager = .init()
    
    func createProduct() {
        guard canCreateProduct,
              let price = Double(price),
              let stock = Int(stock),
              let imageData else { return }
        
        isLoading = true
        
        Task { @MainActor in
            
            defer {
                isLoading = false
            }
            
            do {
                try await productManager.createProduct(name: name,
                                                       description: description,
                                                       salePrice: price,
                                                       purchasePrice: price,
                                                       stock: stock,
                                                       category: category.id,
                                                       imageDataSet: [imageData])
                AlertPresenter.showAlert("Producto creado exitosamente!", type: .info)
                resetProductProperties()
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }
    
    private func resetProductProperties() {
        name = ""
        price = ""
        stock = ""
        description = ""
    }
    
    private func loadImageData() {
        let imageRendered = ImageRenderer(content: imageSelected)
        
        if let cgImage = imageRendered.cgImage {
            let data = NSMutableData()
            guard let imageDestination = CGImageDestinationCreateWithData(data as CFMutableData,
                                                                          UTType.jpeg.identifier as CFString,
                                                                          1,
                                                                          nil)
            else { return }
            
            CGImageDestinationAddImage(imageDestination, cgImage, nil)
            
            if CGImageDestinationFinalize(imageDestination) {
                imageData = data as Data
            }
        }
    }
    
}
