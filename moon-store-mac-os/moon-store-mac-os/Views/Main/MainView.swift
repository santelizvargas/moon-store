//
//  MainView.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 11/16/24.
//

import SwiftUI

struct MainView: View {
    @State private var screenSelection: Screen = .first
    
    var body: some View {
        NavigationSplitView {
            sidebarContent
        } detail: {
            detailContent.minScreenSize()
        }
    }
    
    // MARK: - Components
    
    private var sidebarContent: some View {
        List(Screen.allCases, selection: $screenSelection) { screen in
            NavigationLink(value: screen) {
                Text(screen.title)
            }
        }
        .listStyle(.sidebar)
    }
    
    @ViewBuilder
    private var detailContent: some View {
        switch screenSelection {
            case .first: Text("First View")
            case .second: Text("Second View")
            case .third: Text("Third View")
        }
    }
}

#Preview {
    MainView()
}
