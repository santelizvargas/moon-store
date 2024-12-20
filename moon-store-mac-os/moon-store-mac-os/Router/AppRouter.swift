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
        let route: AppTransition = authenticationRepository.isLoggedUser
        ? .main
        : .login
        return build(for: route)
    }()
    
    private let authenticationRepository: AuthenticationRepository = .init()
    
    func push(_ path: AppTransition) {
        navigationPath.append(path)
    }
    
    func pop() {
        guard !navigationPath.isEmpty else {
            push(.login)
            return
        }
        navigationPath.removeLast()
    }
    
    @ViewBuilder
    func build(for route: AppTransition) -> some View {
        switch route {
            case .login: LoginView()
            case .main: MainView()
        }
    }
}
