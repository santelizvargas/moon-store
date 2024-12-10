//
//  AppRouter.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 9/12/24.
//

import SwiftUI

final class AppRouter: ObservableObject {
    @Published var navigationPath: NavigationPath = .init()
    
    lazy var assosiatedView: some View = {
        let route: AppTransition = LoginManager.isUserLogged ? .main : .login
        return build(for: route)
    }()
    
    func push(_ path: AppTransition) {
        navigationPath.append(path)
    }
    
    func pop() {
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
