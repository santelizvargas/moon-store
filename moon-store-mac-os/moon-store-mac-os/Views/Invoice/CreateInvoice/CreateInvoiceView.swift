//
//  CreateInvoiceView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/11/25.
//

import SwiftUI

struct CreateInvoiceView: View {
    @StateObject private var viewModel: CreateInvoiceViewModel = .init()
    
    var body: some View {
        VStack(spacing: 20) {
            headerActionButtons
            
            clientInformation
            
            PrimaryButton("Agregar fila") {
                viewModel.addInvoiceRow()
            }
            .frame(width: 100)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            invoiceGridList
        }
        .padding()
    }
    
    private var headerActionButtons: some View {
        HStack {
            Group {
                PrimaryButton("Preview") {
                    
                }
                
                PrimaryButton("Crear factura") {
                    
                }
            }
            .frame(width: 100)
        }
        .frame(maxWidth: .infinity,
               alignment: .trailing)
    }
    
    private var clientInformation: some View {
        HStack {
            MSTextField(title: "Nombre del cliente",
                        text: .constant(""))
            
            MSTextField(title: "Identificación del cliente",
                        text: .constant(""))
        }
    }
    
    private var invoiceGridList: some View {
        ScrollView(showsIndicators: false) {
            Grid {
                ForEach(Array($viewModel.invoice.products.enumerated()),
                        id: \.offset) { index, $product in
                    GridRow {
                        MSTextField(title: "Producto",
                                    text: .constant(""))
                        
                        MSTextField(title: "Cantidad",
                                    text: .constant("").allowOnlyNumbers)
                        
                        MSTextField(title: "Descripción",
                                    text: .constant(""))
                        
                        MSTextField(title: "P. Unitario",
                                    text: .constant("").allowOnlyDecimalNumbers)
                        
                        MSTextField(title: "P. Total",
                                    text: .constant("").allowOnlyDecimalNumbers)
                        
                        PrimaryButton("Borrar") {
                            viewModel.removeInvoiceRow(at: index)
                        }
                        .padding(.top, 24)
                    }
                }
            }
            .foregroundStyle(.msWhite)
            .padding()
        }
        .background(.msDarkGray, in: .rect(cornerRadius: 6))
    }
}

#Preview {
    CreateInvoiceView()
}
