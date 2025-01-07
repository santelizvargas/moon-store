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
}
