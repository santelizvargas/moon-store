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
    @Published var wasCreatedSuccessfully: Bool = false
    
    @Published var imageSelected: Image? {
        didSet {
            guard imageSelected != nil else { return }
            loadImageData()
        }
    }
    
    var canCreateProduct: Bool {
        name.isNotEmpty &&
        price.isNotEmpty &&
        description.isNotEmpty &&
        stock.isNotEmpty
    }
    
    private var imageData: Data?
    
    private let productManager: ProductManager = .init()
    
    func addProduct() {
        guard canCreateProduct,
              let price = Double(price),
              let stock = Int(stock),
              let imageData else { return }
        
        isLoading = true
        
        Task {
            
            defer {
                isLoading = false
            }
            
            do {
                try await productManager.addProduct(name: name,
                                                    description: description,
                                                    salePrice: price,
                                                    purchasePrice: price,
                                                    stock: stock,
                                                    category: category.id,
                                                    imageDataSet: [imageData])
                AlertPresenter.showAlert("Producto creado exitosamente!", type: .info)
                resetProductProperties()
                wasCreatedSuccessfully = true
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
        imageSelected = nil
        imageData = nil
    }
    
    private func loadImageData() {
        let imageRendered = ImageRenderer(content: imageSelected)
        
        guard let cgImage = imageRendered.cgImage else { return }
        
        let data = NSMutableData()
        
        guard let imageDestination = CGImageDestinationCreateWithData(
            data as CFMutableData,
            UTType.jpeg.identifier as CFString,
            1,
            nil
        ) else { return }
        
        CGImageDestinationAddImage(imageDestination, cgImage, nil)
        
        guard CGImageDestinationFinalize(imageDestination) else { return }
        
        imageData = data as Data
    }
    
}
