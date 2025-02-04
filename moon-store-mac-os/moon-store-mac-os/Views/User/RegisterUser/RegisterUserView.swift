//
//  RegisterUserView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/7/25.
//

import SwiftUI

private enum Constants {
    static let spacing: CGFloat = 20
    static let gridPadding: CGFloat = 30
    static let gridMinWidth: CGFloat = 600
    static let crossIcon: String = "xmark"
    static let registerButtonWidth: CGFloat = 200
    static let registerButtonHeight: CGFloat = 40
}

struct RegisterUserView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: RegisterUserViewModel = .init()
    
    private let onRegisterSuccess: (UserModel) -> Void
    
    init(onRegisterSuccess: @escaping (UserModel) -> Void) {
        self.onRegisterSuccess = onRegisterSuccess
    }
    
    var body: some View {
        
        VStack {
            headerView
            
            registerForm
                .frame(minWidth: Constants.gridMinWidth)
                .onReceive(viewModel.$userRegistered) { user in
                    guard let user else { return }
                    dismiss()
                    onRegisterSuccess(user)
                }
                .showSpinner($viewModel.isLoading)
            
            registerButton
        }
        .padding(Constants.gridPadding)
    }
    
    private var headerView: some View {
        HStack {
            Text(localized(.viewTitle))
                .font(.title2)
                .leadingInfinity()
            
            
            Button {
                dismiss()
            } label: {
                Image(systemName: Constants.crossIcon)
                    .foregroundStyle(.msPrimary)
            }
            .buttonStyle(.plain)
        }
        .padding(.bottom)
    }
    
    private var registerForm: some View {
        Grid(horizontalSpacing: Constants.spacing,
             verticalSpacing: Constants.spacing) {
            GridRow {
                MSTextField(
                    title: localized(.nameTextField),
                    text: $viewModel.userModel.firstName
                )
                
                MSTextField(
                    title: localized(.lastNameTextField),
                    text: $viewModel.userModel.lastName
                )
            }
            
            GridRow {
                MSTextField(
                    title: localized(.identificationTextField),
                    text: $viewModel.userModel.identification
                )
                
                MSTextField(
                    title: localized(.phoneNumberTextField),
                    text: $viewModel.userModel.phone.allowOnlyNumbers
                )
            }
            
            GridRow {
                MSTextField(
                    title: localized(.addressTextField),
                    text: $viewModel.userModel.address
                )
                
                MSTextField(
                    title: localized(.emailTextField),
                    text: $viewModel.userModel.email
                )
            }
            
            GridRow(alignment: .bottom) {
                MSTextField(
                    title: localized(.passwordTextField),
                    text: $viewModel.userModel.password,
                    isSecure: true
                )
                
                MSTextField(
                    title: localized(.confirmPasswordTextField),
                    text: $viewModel.userModel.confirmPassword,
                    isSecure: true
                )
            }
        }
    }
    
    private var registerButton: some View {
        PrimaryButton(localized(.registerButtonTitle)) {
            viewModel.registerUser()
        }
        .frame(width: Constants.registerButtonWidth,
               height: Constants.registerButtonHeight)
        .disabled(viewModel.cannotRegisterYet)
    }
}

// MARK: - Localized

extension RegisterUserView {
    private enum RegisterUserViewKey {
        case nameTextField
        case lastNameTextField
        case identificationTextField
        case phoneNumberTextField
        case addressTextField
        case emailTextField
        case passwordTextField
        case confirmPasswordTextField
        case registerButtonTitle
        case viewTitle
    }
    
    private func localized(_ key: RegisterUserViewKey) -> String {
        switch key {
            case .nameTextField: "Nombre"
            case .lastNameTextField: "Apellidos"
            case .identificationTextField: "Identificación"
            case .phoneNumberTextField: "Teléfono"
            case .addressTextField: "Dirección"
            case .emailTextField: "Correo electrónico"
            case .passwordTextField: "Contraseña"
            case .confirmPasswordTextField: "Confirmar contraseña"
            case .registerButtonTitle: "Registrar"
            case .viewTitle: "Registrando usuario"
        }
    }
}

#Preview {
    RegisterUserView() { _ in }
}
