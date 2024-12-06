//
//  Sidebar.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 4/12/24.
//

import SwiftUI

struct Sidebar: View {
    @Binding private var screenSelection: Screen
    
    init(screenSelection: Binding<Screen>) {
        _screenSelection = screenSelection
    }
    
    var body: some View {
        VStack {
            Text("LOGO")
                .font(.largeTitle.bold())
                .foregroundStyle(.msPrimary)
            
            List(ScreenSection.allCases) { section in
                Section(section.id.uppercased()) {
                    ForEach(section.screens) { screen in
                        sidebarItem(for: screen)
                    }
                }
            }
            .listStyle(.sidebar)
            
            logoutButton
        }
        .background(.msLightGray)
    }
    
    // MARK: - View Components
    
    private func sidebarItem(for screen: Screen) -> some View {
        Button {
            withAnimation(.smooth) {
                screenSelection = screen
            }
        } label: {
            Label(screen.id, systemImage: screen.iconName)
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity, minHeight: Constants.buttonSize, alignment: .leading)
        .padding(.horizontal, Constants.horizontalPadding)
        .foregroundStyle(screenSelection == screen ? .msWhite : .msDarkBlue)
        .background(screenSelection == screen ? .msPrimary : .clear, in: .rect(cornerRadius: Constants.buttonRadius))
    }
    
    private var logoutButton: some View {
        Button { } label: {
            Label("Cerrar Sesión", systemImage: "person.badge.minus")
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity, minHeight: Constants.buttonSize)
        .foregroundStyle(.msWhite)
        .background(.red, in: .rect(cornerRadius: Constants.buttonRadius))
        .padding()
    }
}

// MARK: - View Constants

extension Sidebar {
    private enum Constants {
        static let buttonRadius: CGFloat = 8
        static let buttonSize: CGFloat = 30
        static let horizontalPadding: CGFloat = 5
    }
}
