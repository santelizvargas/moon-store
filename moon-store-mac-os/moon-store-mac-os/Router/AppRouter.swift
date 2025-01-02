//
//  AppRouter.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 9/12/24.
//

import SwiftUI

final class AppRouter: ObservableObject {
    @Published var navigationPath: NavigationPath = .init()
    
    lazy var associatedView: some View = {
        guard let userLogged = loginViewModel.loggedUser else {
            return build(for: .login)
        }
        return build(for: .main(userLogged))
    }()
    
    private let loginViewModel: LoginViewModel = .init()
    
    func push(_ path: AppTransition) {
        navigationPath.append(path)
    }
    
    func pop() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }
    
    func popToRoot() {
        guard !navigationPath.isEmpty else {
            push(.login)
            return
        }
        navigationPath.removeLast(navigationPath.count)
    }
    
    @ViewBuilder
    func build(for route: AppTransition) -> some View {
        switch route {
            case .login: LoginView()
            case .main(let user): MainView(user: user)
        }
    }
}
