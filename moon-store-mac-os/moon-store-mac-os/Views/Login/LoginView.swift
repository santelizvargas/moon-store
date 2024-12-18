//
//  LoginView.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 18/11/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var router: AppRouter
    @ObservedObject private var viewModel: LoginViewModel = .init()
    
    init(router: AppRouter) {
        self.router = router
    }
    
    var body: some View {
        VStack {
            VStack(spacing: Constants.Container.spacing) {
                Text("Inicia sesión con tu correo de trabajo")
                    .font(.title2.bold())
                    .foregroundStyle(.black)
                
                Text("Usa tu correo de trabajo para iniciar sesión en el espacio de trabajo de tu equipo.")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                
                Divider()
                
                loginForm
            }
            .padding(Constants.Container.padding)
            .frame(
                width: Constants.Container.width,
                height: Constants.Container.height
            )
            .background {
                RoundedRectangle(cornerRadius: Constants.Container.cornerRadius)
                    .fill(.msWhite)
                    .shadow(
                        color: .msLightBlue.opacity(Constants.Container.shadowOpacity),
                        radius: Constants.Container.shadowRadius
                    )
            }
            
            signUpButton
        }
        .screenSize()
        .background(.msLightGray)
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
    
    // MARK: - View Components
    
    private var loginForm: some View {
        VStack(spacing: Constants.formSpacing) {
            MSTextField(
                title: "Correo electrónico",
                placeholder: "tunombre@empresa.com",
                text: $viewModel.email
            )
            .foregroundStyle(.black)
            
            MSTextField(
                title: "Contraseña",
                placeholder: "Ingresa tu contraseña",
                text: $viewModel.password,
                isSecure: true
            )
            .foregroundStyle(.black)
            .overlay(alignment: .topTrailing) {
                Button("¿Olvidaste tu contraseña?") { }
                    .buttonStyle(.plain)
                    .foregroundStyle(.msPrimary)
            }
            
            PrimaryButton("Iniciar sesión") {
                viewModel.login()
            }
            .onReceive(viewModel.$loginSuccess) { success in
                if success { router.push(.main) }
            }
        }
    }
    
    private var signUpButton: some View {
        HStack(spacing: Constants.signUpSpacing) {
            Text("¿Aún no tienes una cuenta?")
                .foregroundStyle(.black)
            
            Button("Regístrate") { }
                .buttonStyle(.plain)
                .foregroundStyle(.blue)
        }
        .padding(.top)
    }
}

// MARK: - View Constants

extension LoginView {
    private enum Constants {
        static let formSpacing: CGFloat = 25
        static let signUpSpacing: CGFloat = 4
        
        enum Container {
            static let spacing: CGFloat = 23
            static let padding: CGFloat = 30
            static let width: CGFloat = 470
            static let height: CGFloat = 440
            static let cornerRadius: CGFloat = 15
            static let shadowRadius: CGFloat = 10
            static let shadowOpacity: CGFloat = 0.4
        }
    }
}
