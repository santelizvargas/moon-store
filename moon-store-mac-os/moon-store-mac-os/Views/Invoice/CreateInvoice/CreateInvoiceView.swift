//
//  CreateInvoiceView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/11/25.
//

import SwiftUI

struct CreateInvoiceView: View {
    @StateObject private var viewModel: CreateInvoiceViewModel = .init()
    @State private var showInvoicePreviewModal: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            headerActionButtons
            
            clientInformation
            
            PrimaryButton("Agregar fila") {
                viewModel.addInvoiceRow()
            }
            .frame(width: 100, height: 30)
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
                PrimaryButton("Preview") {
                    showInvoicePreviewModal.toggle()
                }
                
                PrimaryButton("Crear factura") {
                    viewModel.createInvoice()
                }
                .disabled(true)
            }
            .frame(width: 100, height: 30)
        }
        .frame(maxWidth: .infinity,
               alignment: .trailing)
    }
    
    private var clientInformation: some View {
        HStack {
            MSTextField(title: "Nombre del cliente",
                        text: $viewModel.invoice.clientName)
            
            MSTextField(title: "Identificación del cliente",
                        text: $viewModel.invoice.clientIdentification)
        }
    }
    
    private var invoiceGridList: some View {
        ScrollView(showsIndicators: false) {
            Grid {
                ForEach(Array($viewModel.invoice.products.enumerated()),
                        id: \.offset) { index, $product in
                    GridRow {
                        MSTextField(title: "Producto",
                                    text: $product.name)
                        
                        MSTextField(title: "Cantidad",
                                    text: $product.quantity)
                        
                        MSTextField(title: "Descripción",
                                    text: $product.description)
                        
                        MSTextField(title: "P. Unitario",
                                    text: $product.price)
                        
                        MSTextField(title: "P. Total",
                                    text: .constant(product.totalPrice))
                        
                        PrimaryButton("Borrar",
                                      backgroundColor: .msOrange) {
                            viewModel.removeInvoiceRow(at: index)
                        }
                        .padding(.top, 24)
                        .disabled(viewModel.cannotRemoveInvoiceRow)
                    }
                }
            }
            .padding()
        }
        .background(.msWhite, in: .rect(cornerRadius: 6))
    }
}

#Preview {
    CreateInvoiceView()
}
