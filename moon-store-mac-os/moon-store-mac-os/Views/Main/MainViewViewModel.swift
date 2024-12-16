//
//  MainViewViewModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/15/24.
//

import Foundation

final class MainViewViewModel: ObservableObject {
    private let authenticationRepository: AuthenticationRepository = .init()
    
    func logout() {
        authenticationRepository.logout()
    }
}
