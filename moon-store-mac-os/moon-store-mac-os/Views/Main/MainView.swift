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
    
    var body: some View {
        NavigationSplitView {
            Sidebar(screenSelection: $screenSelection)
        } detail: {
            detailContent
                .screenSize()
                .background(.msLightGray)
        }
        .toolbarBackground(.hidden)
        .navigationBarBackButtonHidden()
        .toolbar(removing: .title)
    }
    
    @ViewBuilder
    private var detailContent: some View {
        switch screenSelection {
            case .products: ProductListView()
            case .users: UserListView()
            default: Text(screenSelection.rawValue)
        }
    }
}
