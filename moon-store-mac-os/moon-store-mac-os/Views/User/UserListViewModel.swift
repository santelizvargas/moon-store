//
//  UserListViewModel.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 3/1/25.
//

import Foundation

final class UserListViewModel: ObservableObject {
    @Published var userList: [UserModel] = []
    @Published var isLoading: Bool = false
    
    private let userManager: UserManager = .init()
    private let decoder: JSONDecoder = .init()
    
    var showEmptyView: Bool {
        userList.isEmpty &&
        !isLoading
    }
    
    var cannotExportList: Bool {
        userList.isEmpty
    }
    
    init() {
        getUsers()
    }
    
    func getUsers() {
        isLoading = true
        
        Task { @MainActor in
            defer { isLoading = false }
            
            do {
                userList = try await userManager.getUsers()
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }
    
    func showEnableUserConfirmationAlert(for id: Int) {
        AlertPresenter.showConfirmationAlert(message: "Estas seguro que quieres habilitar este usuario?",
                                             actionButtonTitle: "Habilitar") { [weak self] in
            guard let self else { return }
            enableUser(with: id)
        }
    }
    
    func showDisableUserConfirmationAlert(for id: Int) {
        AlertPresenter.showConfirmationAlert(message: "Estas seguro que quieres desabilitar este usuario?",
                                             actionButtonTitle: "Desabilitar") { [weak self] in
            guard let self else { return }
            disableUser(with: id)
        }
    }
    
    private func enableUser(with id: Int) {
        isLoading = true
        
        Task { @MainActor in
            defer { isLoading = false }
            
            do {
                try await userManager.enableUser(id: id)
                getUsers()
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }
    
    private func disableUser(with id: Int) {
        isLoading = true
        
        Task { @MainActor in
            defer { isLoading = false }
            
            do {
                try await userManager.disableUser(id: id)
                getUsers()
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }
}
