//
//  ProductDetailView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/4/25.
//

import SwiftUI

private enum Constants {
    static let horizontalSpacing: CGFloat = 25
    static let imageSize: CGFloat = 200
    static let verticalSpacing: CGFloat = 25
    static let modalWidth: CGFloat = 620
    static let modalHeight: CGFloat = 280
    static let crossIcon: String = "xmark"
    static let crossIconScale: CGFloat = 1.5
    static let roundedBadgeVerticalPadding: CGFloat = 8
    static let roundedBadgeCornerRadius: CGFloat = 12
}

struct ProductDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    private let product: ProductModel
    
    init(product: ProductModel) {
        self.product = product
    }
    
    var body: some View {
        HStack(spacing: Constants.horizontalSpacing) {
            MSAsyncImage(url: product.images.first ?? "",
                         size: Constants.imageSize,
                         shape: .rectangle)
            
            VStack(spacing: Constants.verticalSpacing) {
                Text(product.name)
                    .font(.title)
                    .leadingInfinity()
                
                HStack {
                    roundedBadge(with: product.category.title, backgroundColor: .msLightBlue)
                    
                    roundedBadge(with: localizedString(.stockTitle),
                                 backgroundColor: isAvailableProduct ? .msLightBlue : .msOrange)
                }
                .leadingInfinity()
                
                Text(product.description)
                    .foregroundStyle(.black)
                    .leadingInfinity()
                
                Text(localizedString(.priceTitle))
                    .font(.title2)
                    .leadingInfinity()
                
                Spacer()
            }
            .padding()
        }
        .frame(width: Constants.modalWidth,
               height: Constants.modalHeight)
        .padding()
        .overlay(alignment: .topTrailing) {
            Button {
                dismiss()
            } label: {
                Image(systemName: Constants.crossIcon)
                    .foregroundStyle(.msPrimary)
                    .scaleEffect(Constants.crossIconScale)
            }
            .buttonStyle(.plain)
            .padding()
        }
    }
    
    private var isAvailableProduct: Bool {
        product.stock > .zero
    }
    
    private func roundedBadge(with text: String,
                              backgroundColor: Color) -> some View {
        Text(text)
            .foregroundStyle(.msWhite)
            .padding(.horizontal)
            .padding(.vertical, Constants.roundedBadgeVerticalPadding)
            .background(
                backgroundColor,
                in: .rect(cornerRadius: Constants.roundedBadgeCornerRadius)
            )
    }
}

// MARK: Localized

extension ProductDetailView {
    private enum ProductDetailViewKey {
        case stockTitle
        case priceTitle
    }
    
    private func localizedString(_ key: ProductDetailViewKey) -> String {
        switch key {
            case .stockTitle:
                isAvailableProduct
                ? "\(product.stock) disponible(s)"
                : "Agotado"
                
            case .priceTitle:
                "$ \(product.salePrice)"
        }
    }
}
