//
//  InvoiceListView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/8/25.
//

import SwiftUI

private enum Constants {
    static let columnsNumber: Int = 4
    static let gridCellColumns: Int = 2
    static let historyGridPadding: CGFloat = 30
    static let fileName: String = "Historial de ventas"
    static let reloadIcon: String = "arrow.clockwise"
    static let pair: Int = 2
    static let cornerRadius: CGFloat = 6
}

struct InvoiceListView: View {
    @ObservedObject private var viewModel: InvoiceListViewModel = .init()
    @State private var showInvoicePreview: Bool = false
    
    var body: some View {
        VStack {
            ExporterButton(
                title: localized(.exporterButton),
                fileName: Constants.fileName,
                collection: viewModel.invoiceList
            )
            .disabled(viewModel.cannotExportInvoice)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
            
            historyList
            
            if viewModel.canShowCounter {
                TextCounterView(viewModel.invoiceCount)
            }
        }
        .showSpinner($viewModel.isLoading)
        .frame(maxHeight: .infinity, alignment: .top)
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button {
                    viewModel.getInvoices()
                } label: {
                    Image(systemName: Constants.reloadIcon)
                        .foregroundStyle(.msPrimary)
                }
            }
        }
    }
    
    // MARK: - Header List View
    
    private var headerListView: some View {
        Grid(horizontalSpacing: .zero) {
            GridRow {
                Group {
                    Text(localized(.clientRowTitle))
                    Text(localized(.idRowTitle))
                    Text(localized(.dateRowTitle))
                        .gridCellColumns(Constants.gridCellColumns)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .background(.msWhite,
                    in: .rect(cornerRadius: Constants.cornerRadius))
    }
        
    // MARK: - History List View
    
    private var historyList: some View {
        Grid {
            headerListView
            
            if viewModel.shouldShowEmptyView {
                MSEmptyListView {
                    viewModel.getInvoices()
                }
            } else {
                itemRows
            }
        }
        .padding(.horizontal, Constants.historyGridPadding)
        .padding(.vertical)
    }
    
    // MARK: - Item View
    
    private var itemRows: some View {
        GridRow {
            ScrollView(showsIndicators: false) {
                Grid(horizontalSpacing: .zero) {
                    ForEach(Array(viewModel.invoiceList.enumerated()),
                            id: \.offset) { index, invoice in
                        GridRow {
                            Group {
                                Text(invoice.customerName)
                                Text(invoice.customerIdentification)
                                Text(invoice.createdAt.formattedDate ?? localized(.invalidDate))
                                
                                Button(localized(.showInvoiceButton)) {
                                    viewModel.updateInvoiceSelected(with: invoice.id)
                                }
                                .buttonStyle(.plain)
                                .underline()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .background(index % Constants.pair == .zero
                                    ? .clear
                                    : .msWhite,
                                    in: .rect(cornerRadius: Constants.cornerRadius))
                    }
                }
                .onReceive(viewModel.$selectedSale) { sale in
                    guard let _ = sale else { return }
                    showInvoicePreview.toggle()
                }
                .sheet(isPresented: $showInvoicePreview) {
                    if let sale = viewModel.selectedSale {
                        InvoicePreviewView(invoiceSale: sale)
                    }
                }
            }
        }
    }
}

// MARK: - Localized

extension InvoiceListView {
    private enum InvoiceListViewKey {
        case exporterButton
        case clientRowTitle
        case idRowTitle
        case dateRowTitle
        case invalidDate
        case showInvoiceButton
    }
    
    private func localized(_ key: InvoiceListViewKey) -> String {
        switch key {
            case .exporterButton: "Exportar"
            case .clientRowTitle: "Cliente"
            case .idRowTitle: "Identificatión"
            case .dateRowTitle: "Fecha de venta"
            case .invalidDate: "Fecha inválida"
            case .showInvoiceButton: "Ver factura"
        }
    }
}

#Preview {
    InvoiceListView()
}
