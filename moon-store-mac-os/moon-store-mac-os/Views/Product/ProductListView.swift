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
        static let spacing: CGFloat = 15
        static let pensilIcon: String = "pencil"
        static let trashIcon: String = "trash"
        static let optionTitle: String = "Abastecer"
    }
}

private enum ProductTableTitle: String, CaseIterable {
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
        VStack {
            headerTableView
                .background(.msWhite)
                        
            ScrollView(showsIndicators: false) {
                Grid {
                    ForEach(ProductoMockData.mockProductos) { product in
                        productRowView(
                            productName: product.name,
                            category: product.category,
                            numberInStrock: product.inStock,
                            price: product.price
                        )
                        .padding(.vertical)
                        .padding(.horizontal, Constants.ProductRow.horizontalPadding)
                        
                        Divider()
                    }
                }
            }
        }
        .background{
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
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(.black)
                }
            }
            .padding(.vertical)
        }
    }
    
    // MARK: - Table Row View
    
    private func productRowView(productName: String, category: String, numberInStrock: Int, price: String) -> some View {
        GridRow {
            HStack {
                Image(systemName: Constants.personIcon)
                    .resizable()
                    .frame(width: Constants.iconSize, height: Constants.iconSize)
                    .padding(.horizontal)
                
                Text(productName)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.black)
            }
            
            Group {
                Text(category)
                    .padding(Constants.ProductRow.padding)
                    .background(.green, in: .capsule)
                
                Text(numberInStrock.description)
                
                Text(price)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundStyle(.black)
            
            HStack(spacing: Constants.ProductRow.spacing) {
                Text(Constants.ProductRow.optionTitle)
                    .foregroundStyle(.blue)
                    .underline()
                
                Image(systemName: Constants.ProductRow.pensilIcon)
                    .foregroundStyle(.gray)
                
                Image(systemName: Constants.ProductRow.trashIcon)
                    .foregroundStyle(.red)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ProductListView()
}
