//
//  AddProductView+Edit.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//

import SwiftUI
import PhotosUI

private enum Constants {
    static let buttonHeight: CGFloat = 40
    static let horizontalSpacing: CGFloat = 20
    static let hasBorder: Bool = true
    static let minHeight: CGFloat = 30
    static let cornerRadiusSize: CGFloat = 4
    static let photoMaxHeight: CGFloat = 200
    static let detailButtonHeight: CGFloat = 70
    static let strokLengths: CGFloat = 10
    static let spaceSize: CGFloat = 10
    static let minOpacity: CGFloat = 0.6
    static let maxOpacity: CGFloat = 1
    static let loadingImage: String = "square.and.arrow.down"
    static let saveProductImage: String = "square.and.arrow.down.on.square.fill"
    static let productTextFieldMaxHeight: CGFloat = 35
}

struct AddProductView: View {
    @ObservedObject private var viewModel = AddProductViewModel()
    
    var body: some View {
        HStack {
            MSImagePickerView(selectedImage: $viewModel.imageSelected)
            
            productInformationView
        }
        .foregroundStyle(.msPrimary)
        .padding()
        .screenSize()
        .background(.msWhite)
        .showSpinner($viewModel.isLoading)
        .overlay(alignment: .top) {
            HStack {
                Text("Agregando producto")
                    .font(.headline)
                
                Spacer()
                
                Button("Agregar producto") {
                    viewModel.createProduct()
                }
                .disabled(viewModel.canCreateProduct)
                .opacity(viewModel.canCreateProduct
                         ? Constants.minOpacity
                         : Constants.maxOpacity)
            }
            .leadingInfinity()
            .padding()
            .foregroundStyle(.msPrimary)
        }
    }
    
    // MARK: - Product Information
    
    private var productInformationView: some View {
        VStack {
            MSTextField(
                title: "Nombre del producto",
                text: $viewModel.name
            )
            
            MSTextField(
                title: "Precio",
                text: $viewModel.price.allowOnlyDecimalNumbers
            )

            MSTextField(
                title: "Unidades disponibles",
                text: $viewModel.stock.allowOnlyNumbers
            )
            
            MSTextField(title: "Descripción", text: $viewModel.description)
            
            categoryButton
        }
    }
    
    // MARK: - Category Button
    
    private var categoryButton: some View {
        Menu {
            ForEach(ProductCategory.allCases) { category in
                Button(category.title) {
                    viewModel.category = category
                }
            }
        } label: {
            Text(viewModel.category.title)
                .leadingInfinity()
                .foregroundStyle(.msPrimary)
        }
        .overlay {
            RoundedRectangle(cornerRadius: Constants.cornerRadiusSize)
                .stroke(.msGray)
        }
    }
}

#Preview {
    AddProductView()
}

