//
//  CreateInvoiceView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/11/25.
//

import SwiftUI

private enum Constants {
    static let viewSpacing: CGFloat = 20
    static let buttonWidth: CGFloat = 100
    static let buttonHeight: CGFloat = 30
    static let deleteButtonTopPadding: CGFloat = 24
    static let gridListCornerRadius: CGFloat = 6
}

struct CreateInvoiceView: View {
    @StateObject private var viewModel: CreateInvoiceViewModel = .init()
    @State private var showInvoicePreviewModal: Bool = false
    
    var body: some View {
        VStack(spacing: Constants.viewSpacing) {
            headerActionButtons
            
            clientInformation
            
            PrimaryButton(localized(.addRowButton)) {
                viewModel.addInvoiceRow()
            }
            .frame(width: Constants.buttonWidth,
                   height: Constants.buttonHeight)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            invoiceGridList
        }
        .padding()
        .sheet(isPresented: $showInvoicePreviewModal) {
            InvoicePreviewView(invoiceSale: viewModel.invoice)
        }
    }
    
    private var headerActionButtons: some View {
        HStack {
            Group {
                PrimaryButton(localized(.previewButton)) {
                    showInvoicePreviewModal.toggle()
                }
                
                PrimaryButton(localized(.createInvoiceButton)) {
                    viewModel.createInvoice()
                }
                .disabled(viewModel.cannotCreateInvoice)
            }
            .frame(width: Constants.buttonWidth,
                   height: Constants.buttonHeight)
        }
        .frame(maxWidth: .infinity,
               alignment: .trailing)
    }
    
    private var clientInformation: some View {
        HStack {
            MSTextField(title: localized(.clientNameField),
                        text: $viewModel.invoice.clientName)
            
            MSTextField(title: localized(.clientIdentificationField),
                        text: $viewModel.invoice.clientIdentification)
        }
    }
    
    private var invoiceGridList: some View {
        ScrollView(showsIndicators: false) {
            Grid {
                ForEach(Array($viewModel.invoice.products.enumerated()),
                        id: \.offset) { index, $product in
                    GridRow {
                        VStack {
                            Text(localized(.productMenuTitle))
                            
                            Menu(product.name) {
                                ForEach(viewModel.products) { productForSelect in
                                    Button(productForSelect.name) {
                                        product.selectedProduct = productForSelect
                                    }
                                }
                            }
                            .frame(maxHeight: .infinity,
                                   alignment: .center)
                        }
                        .frame(maxHeight: .infinity,
                               alignment: .top)
                        
                        MSTextField(title: localized(.quantityTitle),
                                    text: $product.quantity.allowOnlyNumbers)
                        
                        MSTextField(title: localized(.descriptionTitle),
                                    text: $product.description)
                        
                        MSTextField(title: localized(.unitPriceTitle),
                                    text: $product.price)
                        .disabled(true)
                        
                        MSTextField(title: localized(.totalPriceTitle),
                                    text: .constant(product.totalPrice))
                        .disabled(true)
                        
                        PrimaryButton(localized(.deleteRowButton),
                                      backgroundColor: .msOrange) {
                            viewModel.removeInvoiceRow(at: index)
                        }
                        .padding(.top, Constants.deleteButtonTopPadding)
                        .disabled(viewModel.cannotRemoveInvoiceRow)
                    }
                }
            }
            .padding()
        }
        .background(.msWhite, in: .rect(cornerRadius: Constants.gridListCornerRadius))
    }
}

// MARK: - Localized

extension CreateInvoiceView {
    private enum LocalizedKey {
        case addRowButton
        case previewButton
        case createInvoiceButton
        case clientNameField
        case clientIdentificationField
        case productMenuTitle
        case quantityTitle
        case descriptionTitle
        case unitPriceTitle
        case totalPriceTitle
        case deleteRowButton
    }
    
    private func localized(_ key: LocalizedKey) -> String {
        switch key {
            case .addRowButton: "Agregar fila"
            case .previewButton: "Previzualizar"
            case .createInvoiceButton: "Create Invoice"
            case .clientNameField: "Nombre del cliente"
            case .clientIdentificationField: "Identificación del cliente"
            case .productMenuTitle: "Producto"
            case .quantityTitle: "Cantidad"
            case .descriptionTitle: "Descripción"
            case .unitPriceTitle: "P. Unitario"
            case .totalPriceTitle: "P. Total"
            case .deleteRowButton: "Borrar"
        }
    }
}

#Preview {
    CreateInvoiceView()
}
