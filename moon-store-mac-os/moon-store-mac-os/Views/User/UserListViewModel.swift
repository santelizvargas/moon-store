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
    
    private let networkManager: NetworkManager = .init()
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
                let data = try await networkManager.getData(for: .users)
                let response = try decoder.decode(UserResponse.self, from: data)
                userList = response.users
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }
}
