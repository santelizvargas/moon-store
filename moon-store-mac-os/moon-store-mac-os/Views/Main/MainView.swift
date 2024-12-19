//
//  MainView.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 11/16/24.
//

import SwiftUI

struct MainView: View {
    @State private var screenSelection: Screen = .charts
    @ObservedObject private var router: AppRouter
    @ObservedObject private var viewModel: MainViewViewModel = .init()
    
    init(router: AppRouter) {
        self.router = router
    }
    
    var body: some View {
        NavigationSplitView {
            Sidebar(
                screenSelection: $screenSelection) {
                    viewModel.logout()
                    router.pop()
                }
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
            default: Text(screenSelection.rawValue)
        }
    }
}
