//
//  MainView.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 11/16/24.
//

import SwiftUI

private enum Constants {
    static let profileButtonSize: CGFloat = 25
    static let profileIcon: String = "person.circle.fill"
}

struct MainView: View {
    @EnvironmentObject private var router: AppRouter
    @State private var screenSelection: Screen = .charts
    
    private let user: UserModel
    
    init(user: UserModel) {
        self.user = user
    }
    
    var body: some View {
        NavigationSplitView {
            Sidebar(screenSelection: $screenSelection)
        } detail: {
            detailContent
                .screenSize()
                .background(.msLightGray)
                .navigationTitle(screenSelection.id)
        }
        .toolbarBackground(.hidden)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                profileButton
            }
        }
    }
    
    @ViewBuilder
    private var detailContent: some View {
        switch screenSelection {
            case .products: ProductListView()
            case .users: UserListView()
            default: Text(screenSelection.rawValue)
        }
    }
    
    private var profileButton: some View {
        Button {
            // TODO: - Navigate to the profile screen and remove placeholder alert
            AlertPresenter.showAlert("Profile feature is under development. Stay tuned for updates!")
        } label: {
            Image(systemName: Constants.profileIcon)
                .resizable()
                .frame(square: Constants.profileButtonSize)
        }
        .buttonStyle(.plain)
    }
}
