//
//  MainView.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 11/16/24.
//

import SwiftUI

struct MainView: View {
    @State private var screenSelection: Screen = .charts
    
    var body: some View {
        NavigationSplitView {
            Sidebar(screenSelection: $screenSelection)
        } detail: {
            detailContent
                .screenSize()
                .background(.msLightGray)
        }
    }
    
    @ViewBuilder
    private var detailContent: some View {
        Button(screenSelection.rawValue) {
            _Concurrency.Task {
                try await BaseNetworkService().getData(path: .productCount)
            }
        }
    }
}

#Preview {
    MainView()
}
