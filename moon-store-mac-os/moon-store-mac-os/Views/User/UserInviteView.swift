//
//  UserInviteView.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 28/12/24.
//

import SwiftUI

private enum Constants {
    static let iconSize: CGFloat = 16
    static let iconTitle: String = "xmark.circle.fill"
    static let placeholder: String = "example@example.com"
    static let height: CGFloat = 120
    static let verticalpadding: CGFloat = 5
    static let buttonHeight: CGFloat = 100
    static let cornerRadius: CGFloat = 10
    static let padding: CGFloat = 10
    static let textFieldHeight: CGFloat = 40
}

struct UserInviteView: View {
    @Binding private var isShowing: Bool
    @State private var emailValue: String = ""
    
    init(isShowing: Binding<Bool>) {
        _isShowing = isShowing
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                isShowing.toggle()
            } label: {
                Image(systemName: Constants.iconTitle)
                    .resizable()
                    .frame(width: Constants.iconSize,
                           height: Constants.iconSize)
                    .foregroundStyle(.red)
            }
            .buttonStyle(.plain)
            .padding(.vertical, Constants.verticalpadding)
            
            Text(localizedString(.emial))
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .bold()
            
            HStack {
                TextField(Constants.placeholder,
                          text: $emailValue)
                .frame(height: Constants.textFieldHeight)
                .textFieldStyle(.plain)
                .foregroundStyle(.black)
                .background(.msWhite)
                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                
                Button(localizedString(.invite)) {
                    isShowing.toggle()
                }
                .foregroundStyle(.msWhite)
                .buttonStyle(.plain)
                .frame(minWidth: Constants.buttonHeight)
                .padding(.vertical, Constants.padding)
                .background(emailValue.isEmpty ? .msGray : .msPrimary,
                            in: .rect(cornerRadius: Constants.cornerRadius))
                .disabled(emailValue.isEmpty)
            }
        }
        .frame(minHeight: Constants.height,
               alignment: .top)
        .padding(.horizontal)
        .background(.msLightGray)
    }
}

extension UserInviteView {
    private enum TitleValue {
        case emial, invite
    }
    
    private func localizedString(_ key: TitleValue) -> String {
        switch key {
            case .emial: "Dirección de correo:"
            case .invite: "Invitar"
        }
    }
}
