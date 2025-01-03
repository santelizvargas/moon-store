//
//  AddProductView+Edit.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//

import SwiftUI
import PhotosUI

private enum Constants {
    static let cornerRadiusSize: CGFloat = 4
    static let createButtonWidth: CGFloat = 200
    static let crossIcon: String = "xmark"
    static let modalMinHeight: CGFloat = 450
    static let modalMinWidth: CGFloat = 650
}

struct AddProductView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel = AddProductViewModel()
    
    var body: some View {
        VStack {
            
            modalHeader
            
            HStack {
                MSImagePickerView(selectedImage: $viewModel.imageSelected)
                
                productInformationView
            }
            .padding(.vertical)
            
            PrimaryButton("Crear producto") {
                viewModel.createProduct()
            }
            .frame(width: Constants.createButtonWidth)
        }
        .padding()
        .frame(minWidth: Constants.modalMinWidth,
               minHeight: Constants.modalMinHeight,
               alignment: .top)
        .background(.msWhite)
        .showSpinner($viewModel.isLoading)
        .onReceive(viewModel.$wasCreatedSuccessfully) { success in
            guard success else { return }
            dismiss()
        }
    }
    
    private var modalHeader: some View {
        HStack {
            Text("Agregando producto")
                .font(.headline)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Image(systemName: Constants.crossIcon)
            }
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
    
    // MARK: - Category Menu
    
    private var categoryButton: some View {
        Menu(viewModel.category.title) {
            ForEach(ProductCategory.allCases) { category in
                Button(category.title) {
                    viewModel.category = category
                }
            }
        }
        .foregroundStyle(.msPrimary)
        .overlay {
            RoundedRectangle(cornerRadius: Constants.cornerRadiusSize)
                .stroke(.msGray)
        }
    }
}

#Preview {
    AddProductView()
}

