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
        .toolbarBackground(.hidden)
        .navigationBarBackButtonHidden()
        .toolbar(removing: .title)
    }
    
    @ViewBuilder
    private var detailContent: some View {
        Text(screenSelection.rawValue)
    }
}

#Preview {
    MainView()
}
