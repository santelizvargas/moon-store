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
    static let totalSpacing: CGFloat = 20
    static let productGridSpacing: CGFloat = 30
    static let cornerRadius: CGFloat = 10
    static let maxWidth: CGFloat = 700
    static let minHeight: CGFloat = 600
    static let logoSize: CGFloat = 100
    static let ivaValue: CGFloat = 0.15
    static let previewIcon: String = "xmark"
    static let dashSymbol: String = "-"
}

struct InvoicePreviewView: View {
    private let invoiceSale: InvoiceSaleModel
    
    init(invoiceSale: InvoiceSaleModel) {
        self.invoiceSale = invoiceSale
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            contentView
        }
        .padding(.vertical)
        .padding(.horizontal, Constants.productGridSpacing)
        .frame(
            minHeight: Constants.minHeight,
            maxHeight: .infinity
        )
        .frame(width: Constants.maxWidth)
        .background(.msWhite,
                    in: .rect(cornerRadius: Constants.cornerRadius))
    }
    
    private var contentView: some View {
        VStack(spacing: Constants.spacing) {
            headerView
            
            VStack(alignment: .leading, spacing: Constants.userSpacing) {
                Text(localized(.ownerPhone))
                Text(localized(.ownerEmail))
                Text(localized(.ownerAddress))
            }
            .leadingInfinity()
            
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
                    
                    ForEach(invoiceSale.products) { product in
                        GridRow {
                            Text(product.quantity.description)
                            Text(product.name)
                            Text(localized(.currencyText(Double(product.price) ?? 0)))
                            Text(localized(.currencyText(Double(product.totalPrice) ?? 0)))
                        }
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .strokeBorder(.black)
                }
            }
            .leadingInfinity()
            
            Grid(alignment: .leading, horizontalSpacing: Constants.totalSpacing) {
                totalGridRow(name: localized(.subTotal), value: invoiceSale.subtotalPrice)
                totalGridRow(name: localized(.IVA), value: invoiceSale.totalIva)
                totalGridRow(name: localized(.total), value: invoiceSale.totalPrice)
            }
            .padding([.horizontal, .bottom])
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Spacer()
        }
    }
    
    // MARK: - Header View
    
    private var headerView: some View {
        HStack {
            Image(systemName: Constants.previewIcon)
                .resizable()
                .frame(square: Constants.logoSize)
                .foregroundStyle(.msPrimary)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: Constants.userSpacing) {
                Text(localized(.bill))
                    .bold()
                +
                Text(invoiceSale.id > .zero
                     ? invoiceSale.id.description
                     : Constants.dashSymbol)
                
                Text(invoiceSale.createAt)
            }
        }
    }
    
    // MARK: - Total Grid Row
    
    private func totalGridRow(name: String, value: Double) -> some View {
        GridRow {
            Text(name)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text(localized(.currencyText(value)))
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
        case currencyText(Double)
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
            case .currencyText(let value): "$ \(value.numberFormatted)"
        }
    }
}

#Preview {
    InvoicePreviewView(invoiceSale: .init())
}
