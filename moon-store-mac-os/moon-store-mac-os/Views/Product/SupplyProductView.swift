//
//  SupplyProductView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/3/25.
//

import SwiftUI

private enum Constants {
    static let crossIcon: String = "xmark"
    static let crossButtonSize: CGFloat = 18
    static let supplyButtonMaxWidth: CGFloat = 100
    static let supplyButtonTopPadding: CGFloat = 22
    static let modalWidth: CGFloat = 400
    static let modalHight: CGFloat = 100
    static let lineLimit: Int = 1
}

struct SupplyProductView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var quantity: String = ""
    
    private let supplyProduct: (String) -> Void
    
    init(supplyProduct: @escaping (String) -> Void) {
        self.supplyProduct = supplyProduct
    }
    
    var body: some View {
        VStack {
            headerView
            
            formView
        }
        .frame(width: Constants.modalWidth,
               height: Constants.modalHight)
        .padding()
    }
    
    private var headerView: some View {
        HStack {
            Text(localizedString(.title))
                .leadingInfinity()
                .font(.title2)
                .lineLimit(Constants.lineLimit)
            
            Button {
                dismiss()
            } label: {
                Image(systemName: Constants.crossIcon)
                    .resizable()
                    .frame(square: Constants.crossButtonSize)
            }
            .buttonStyle(.plain)
        }
        .foregroundStyle(.msPrimary)
    }
    
    private var formView: some View {
        HStack {
            MSTextField(title: localizedString(.textFieldTitle),
                        text: $quantity.allowOnlyNumbers)
            
            PrimaryButton(localizedString(.supplyButton)) {
                supplySuccess()
            }
            .disabled(quantity.isEmpty)
            .frame(maxWidth: Constants.supplyButtonMaxWidth)
            .padding(.top, Constants.supplyButtonTopPadding)
        }
    }
    
    private func supplySuccess() {
        dismiss()
        supplyProduct(quantity)
    }
}

// MARK: - Localized

extension SupplyProductView {
    private enum SupplyProductViewKey {
        case title
        case textFieldTitle
        case supplyButton
    }
    
    private func localizedString(_ key: SupplyProductViewKey) -> String {
        switch key {
            case .title: "Abasteciendo producto"
            case .textFieldTitle: "Cantidad"
            case .supplyButton: "Abastecer"
        }
    }
}

#Preview {
    SupplyProductView { _ in }
}
