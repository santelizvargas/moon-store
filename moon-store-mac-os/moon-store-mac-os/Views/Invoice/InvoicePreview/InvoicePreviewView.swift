//
//  InvoicePreviewView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/8/25.
//

import SwiftUI

private enum Constants {
    static let spacing: CGFloat = 20
    static let userSpacing: CGFloat = 8
    static let gridSpacing: CGFloat = 4
    static let totalSpacing: CGFloat = 10
    static let productGridSpacing: CGFloat = 30
    static let cornerRadius: CGFloat = 10
    static let minWidth: CGFloat = 800
    static let minHeight: CGFloat = 500
    static let logoSize: CGFloat = 100
    static let previewIcon: String = "xmark"
    static let pdfFileName: String = "MS Gráficos"
}

struct InvoicePreviewView: View {
    private let invoiceSale: InvoiceSaleModel
    
    init(invoiceSale: InvoiceSaleModel) {
        self.invoiceSale = invoiceSale
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            headerView
            
            contentView
        }
        .frame(minWidth: Constants.minWidth,
               minHeight: Constants.minHeight)
        .padding()
        .background(
            .msWhite,
            in: .rect(cornerRadius: Constants.cornerRadius)
        )
        .toolbar {
            ToolbarItem {
                PDFExporterButton(fileName: Constants.pdfFileName) {
                    viewForPDF
                }
            }
        }
    }
    
    // MARK: - View for PDF
    
    private var viewForPDF: some View {
        VStack {
            headerView
            
            contentView
            
        }.frame(minWidth: Constants.minWidth,
                minHeight: Constants.minHeight)
         .padding()
         .background(
             .msWhite,
             in: .rect(cornerRadius: Constants.cornerRadius)
         )
    }
    
    private var contentView: some View {
        VStack(spacing: Constants.spacing) {
            ownerInformation
            
            clientInformation
            
            invoiceInformation
            
            invoiceSummary
        }
    }
    
    // MARK: - Header View
    
    private var headerView: some View {
        HStack {
            
            MSLogo()
                .leadingInfinity()
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: Constants.userSpacing) {
                HStack {
                    Text(localized(.bill))
                        .bold()
                    
                    Text(invoiceSale.id.description)
                }
                
                Text(invoiceSale.createAt)
            }
        }
    }
    
    // MARK: Invoice summary
    
    private var invoiceSummary: some View {
        Grid(alignment: .leading, horizontalSpacing: Constants.totalSpacing) {
            totalGridRow(name: localized(.subTotal),
                         value: invoiceSale.subtotalPrice)
            
            totalGridRow(name: localized(.IVA),
                         value: invoiceSale.totalIva)
            
            totalGridRow(name: localized(.total),
                         value: invoiceSale.totalPrice)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    // MARK: - Client information
    
    private var clientInformation: some View {
        VStack(alignment: .leading, spacing: Constants.userSpacing) {
            Text(localized(.clientData))
                .font(.title3.bold())
            
            Grid(alignment: .leading, verticalSpacing: Constants.gridSpacing) {
                GridRow {
                    Text(localized(.name))
                    Text(invoiceSale.clientName)
                }
                
                GridRow {
                    Text(localized(.identification))
                    Text(invoiceSale.clientIdentification)
                }
            }
        }
        .leadingInfinity()
    }
    
    // MARK: Invoice information
    
    private var invoiceInformation: some View {
        VStack(alignment: .leading, spacing: Constants.userSpacing) {
            Text(localized(.invoiceDetail))
                .font(.title3.bold())
            
            Grid(alignment: .leading,
                 horizontalSpacing: Constants.productGridSpacing,
                 verticalSpacing: Constants.totalSpacing) {
                
                GridRow {
                    Text(localized(.amount))
                    
                    Text(localized(.description))
                        .leadingInfinity()
                    
                    Text(localized(.unitPrice))
                    
                    Text(localized(.totalPrice))
                }
                .bold()
                
                ForEach(invoiceSale.products, id: \.idString) { product in
                    MSDivider(color: .msBlack)
                    
                    GridRow {
                        Text(product.quantity.description)
                        Text(product.name)
                        Text(localized(.currencyValue(Double(product.price))))
                        Text(localized(.currencyValue(Double(product.totalPrice))))
                    }
                }
            }
            .padding()
            .background {
                RoundedRectangle(
                    cornerRadius: Constants.cornerRadius
                )
                .strokeBorder(.msBlack)
            }
        }
        .leadingInfinity()
    }
    
    // MARK: - Owner information
    
    private var ownerInformation: some View {
        VStack(alignment: .leading, spacing: Constants.userSpacing) {
            Text(localized(.ownerPhone))
            Text(localized(.ownerEmail))
            Text(localized(.ownerAddress))
        }
        .leadingInfinity()
    }
    
    // MARK: - Total Grid Row
    
    private func totalGridRow(name: String, value: Double) -> some View {
        GridRow {
            Text(name)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text(localized(.currencyValue(value)))
        }
    }
}

// MARK: - Localized

extension InvoicePreviewView {
    private enum LocalizedKey {
        case ownerPhone
        case ownerEmail
        case ownerAddress
        case clientData
        case name
        case identification
        case invoiceDetail
        case amount
        case description
        case unitPrice
        case totalPrice
        case subTotal
        case IVA
        case total
        case bill
        case currencyValue(Double?)
    }
    
    private func localized(_ key: LocalizedKey) -> String {
        switch key {
            case .ownerPhone: "+505 5730 1190"
            case .ownerEmail: "lunajose6969@gmail.com"
            case .ownerAddress: "San Jacinto, León - Nicaragua"
            case .clientData: "Datos del cliente"
            case .name: "Nombre: "
            case .identification: "Identificación: "
            case .invoiceDetail: "Detalles de factura"
            case .amount: "Cantidad"
            case .description: "Descripción"
            case .unitPrice: "P. Unitario"
            case .totalPrice: "P. Total"
            case .subTotal: "Subtotal: "
            case .IVA: "IVA: "
            case .total: "Total: "
            case .bill: "Factura: "
            case .currencyValue(let value): "$ \(value ?? .zero)"
        }
    }
}

#Preview {
    InvoicePreviewView(invoiceSale: .init())
}
