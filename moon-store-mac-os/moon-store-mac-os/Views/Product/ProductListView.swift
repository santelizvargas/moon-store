//
//  ProductListView.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 11/12/24.
//

import SwiftUI

private enum Constants {
    static let cornerRadius: CGFloat = 10
    static let iconSize: CGFloat = 30
    static let plusIcon: String = "plus.circle"
    static let personIcon: String = "person.circle.fill"
    static let headerTitle: String = "Lista de Productos"
    
    enum Button {
        static let title: String = "Agregar Producto"
    }
    
    enum ProductRow {
        static let horizontalPadding: CGFloat = 5
        static let padding: CGFloat = 6
        static let spacing: CGFloat = 10
        static let pensilIcon: String = "pencil"
        static let trashIcon: String = "trash"
        static let optionTitle: String = "Abastecer"
        static let iconSize: CGFloat = 20
        static let hStackSpacing: CGFloat = -10
        static let lineLimit: Int = 1
        static let opacity: CGFloat = 0.2
        static let evenNumber: Int = 2
    }
}

private enum ProductTableTitle: String, CaseIterable {
    case productIcon
    case product
    case category
    case inStock
    case price
    case options
    
    var title: String {
        switch self {
            case .product: "Producto"
            case .category: "Categoría"
            case .inStock: "En Stock"
            case .price: "Precio"
            case .options: ""
            case .productIcon: ""
        }
    }
}

struct ProductListView: View {
    @State private var searchValue: String = ""
    
    var body: some View {
        VStack {
            headerView
            
            HStack {
                SearchView(searchText: $searchValue)
                
                Spacer()
                
                Button {
                    // TODO: Add action when available
                } label: {
                    Label(Constants.Button.title, systemImage: Constants.plusIcon)
                        .foregroundStyle(.msWhite)
                }
                .buttonStyle(.plain)
                .padding(Constants.cornerRadius)
                .background {
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .fill(.msPrimary)
                }
            }
            .padding(.bottom)
            
            productTableView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal)
        .background(.msLightGray)
    }
    
    // MARK: - Header View
    
    private var headerView: some View {
        HStack {
            Text(Constants.headerTitle)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: Constants.personIcon)
                .resizable()
                .frame(width: Constants.iconSize, height: Constants.iconSize)
        }
        .padding(.vertical)
        .foregroundStyle(.black)
    }
    
    // MARK: - Table View
    
    private var productTableView: some View {
        VStack(spacing: .zero) {
            headerTableView
                .background(.msWhite)
            
            ScrollView(showsIndicators: false) {
                Grid(horizontalSpacing: .zero, verticalSpacing: .zero) {
                    ForEach(Array(ProductoMockData.mockProductos.enumerated()), id: \.element.id) { index, product in
                        HStack(spacing: Constants.ProductRow.hStackSpacing) {
                            productRowView(
                                productName: product.name,
                                category: product.category,
                                numberInStrock: product.inStock,
                                price: product.price
                            )
                            .padding(.vertical)
                        }
                        .background(index % Constants.ProductRow.evenNumber == .zero
                                    ? .msLightGray
                                    : .msWhite)
                    }
                }
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(.msGray)
        }
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
    }
    
    // MARK: - Header Table View
    
    private var headerTableView: some View {
        Grid {
            GridRow {
                ForEach(ProductTableTitle.allCases, id: \.self) { title in
                    Text(title.title)
                        .frame(maxWidth: .infinity,
                               alignment: title == .product ? .leading : .center)
                        .foregroundStyle(.black)
                        .font(.body)
                        .bold()
                }
            }
            .padding(.vertical)
        }
    }
    
    // MARK: - Table Row View
    
    private func productRowView(productName: String, category: CategoryType, numberInStrock: Int, price: String) -> some View {
        GridRow {
            Image(systemName: Constants.personIcon)
                .resizable()
                .frame(width: Constants.iconSize,
                       height: Constants.iconSize)
                .padding(.horizontal)
            
            Text(productName)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .foregroundStyle(.black)
                .lineLimit(Constants.ProductRow.lineLimit)
            
            Group {
                Text(category.rawValue)
                    .padding(Constants.ProductRow.padding)
                    .foregroundStyle(category.color)
                    .background(category.color.opacity(Constants.ProductRow.opacity),
                                in: .capsule)
                
                Text(numberInStrock.description)
                    .foregroundStyle(.msDarkGray)
                    .frame(alignment: .center)
                
                Text(price)
                    .foregroundStyle(.msDarkGray)
            }
            .frame(maxWidth: .infinity)
            
            opctionsView
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Product options view
    
    private var opctionsView: some View {
        HStack(spacing: Constants.ProductRow.spacing) {
            Text(Constants.ProductRow.optionTitle)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .foregroundStyle(.blue)
                .underline()
            
            Image(.edit)
                .resizable()
                .frame(width: Constants.ProductRow.iconSize,
                       height: Constants.ProductRow.iconSize)
                .foregroundStyle(.msGray)
            
            Image(systemName: Constants.ProductRow.trashIcon)
                .resizable()
                .frame(width: Constants.ProductRow.iconSize,
                       height: Constants.ProductRow.iconSize)
                .foregroundStyle(.red)
        }
        .padding(.trailing)
    }
}

#Preview {
    ProductListView()
}
