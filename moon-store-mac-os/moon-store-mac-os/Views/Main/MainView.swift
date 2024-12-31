//
//  MainView.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 11/16/24.
//

import SwiftUI

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
                .navigationTitle(user.firstName)
        }
        .toolbarBackground(.hidden)
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    private var detailContent: some View {
        switch screenSelection {
            case .products: ProductListView()
            default: Text(screenSelection.rawValue)
        }
    }
}
