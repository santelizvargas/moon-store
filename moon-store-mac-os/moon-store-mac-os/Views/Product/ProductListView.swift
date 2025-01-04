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
        static let opacity: CGFloat = 0.1
        static let pairNumber: Int = 2
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
            case .options, .productIcon: ""
        }
    }
}

struct ProductListView: View {
    @StateObject private var viewModel: ProductListViewModel = .init()
    @State private var showAddProductModal: Bool = false
    @State private var showSupplyProductModal: Bool = false

    var body: some View {
        VStack {
            HStack {
                SearchView(searchText: $viewModel.searchText)
                    .leadingInfinity()

                Button {
                    showAddProductModal.toggle()
                } label: {
                    Label("Agregar Producto", systemImage: Constants.plusIcon)
                        .foregroundStyle(.msWhite)
                }
                .buttonStyle(.plain)
                .padding(Constants.cornerRadius)
                .background(
                    .msPrimary,
                    in: .rect(cornerRadius: Constants.cornerRadius))
            }
            .padding(.bottom)
            .sheet(isPresented: $showAddProductModal) {
                AddProductView()
            }
            .sheet(isPresented: $showSupplyProductModal) {
                SupplyProductView(
                    productName: viewModel.productSelected?.name ?? ""
                ) { quantity in
                    viewModel.supplyProductSelectedProduct(quantity)
                }
            }

            productTableView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal)
        .background(.msLightGray)
    }
    
    // MARK: - Table View

    private var productTableView: some View {
        VStack(spacing: .zero) {
            headerTableView

            productList
        }
        .overlay {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(.msGray)
            
            if viewModel.shouldShowEmptyView {
                MSEmptyListView {
                    viewModel.getProducts()
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
        .showSpinner($viewModel.isLoading)
    }

    // MARK: - Header Table View
    
    private var productList: some View {
        ScrollView(showsIndicators: false) {
            Grid(horizontalSpacing: .zero, verticalSpacing: .zero) {
                ForEach(viewModel.productList.indices, id: \.self) { index in
                    HStack {
                        productRowView(viewModel.productList[index])
                            .padding(.vertical)
                    }
                    .background(
                        index % Constants.ProductRow.pairNumber == .zero
                        ? .msLightGray
                        : .msWhite
                    )
                }
            }
        }
    }

    private var headerTableView: some View {
        Grid {
            GridRow {
                ForEach(ProductTableTitle.allCases, id: \.self) { title in
                    Text(title.title)
                        .frame(
                            maxWidth: .infinity,
                            alignment: title == .product ? .leading : .center
                        )
                        .foregroundStyle(.black)
                        .font(.body)
                        .bold()
                }
            }
            .padding(.vertical)
        }
        .background(.msWhite)
    }

    // MARK: - Table Row View

    private func productRowView(_ product: ProductModel) -> some View {
        GridRow {
            MSAsyncImage(url: product.images.first ?? "",
                         size: Constants.iconSize)

            Text(product.name)
                .leadingInfinity()
                .foregroundStyle(.black)
                .lineLimit(Constants.ProductRow.lineLimit)

            Group {
                Text(product.category.title)
                    .padding(Constants.ProductRow.padding)
                    .foregroundStyle(product.category.color)
                    .background(
                        product.category.color.opacity(Constants.ProductRow.opacity),
                        in: .capsule)

                Text(product.stock.description)
                    .foregroundStyle(.msDarkGray)
                    .frame(alignment: .center)

                Text(product.salePrice.description)
                    .foregroundStyle(.msDarkGray)
            }
            .frame(maxWidth: .infinity)

            optionsView(for: product)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Product options view

    private func optionsView(for product: ProductModel) -> some View {
        HStack(spacing: Constants.ProductRow.spacing) {
            Button {
                showSupplyProductModal.toggle()
                viewModel.updateSelectedProduct(with: product.id)
            } label: {
                Text(Constants.ProductRow.optionTitle)
                    .leadingInfinity()
                    .foregroundStyle(.blue)
                    .underline()
            }
            .buttonStyle(.plain)

            Image(.edit)
                .resizable()
                .frame(
                    width: Constants.ProductRow.iconSize,
                    height: Constants.ProductRow.iconSize
                )
                .foregroundStyle(.msGray)

            Button {
                viewModel.showDeleteAlert()
            } label: {
                Image(systemName: Constants.ProductRow.trashIcon)
                    .resizable()
                    .frame(square: Constants.ProductRow.iconSize)
                    .foregroundStyle(.red)
            }
            .buttonStyle(.plain)
        }
        .padding(.trailing)
    }
}

#Preview {
    ProductListView()
}
