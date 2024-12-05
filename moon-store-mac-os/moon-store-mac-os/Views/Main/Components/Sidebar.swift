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
            
            Button { } label: {
                Label("Cerrar Sesión", systemImage: "person.badge.minus")
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, minHeight: 30)
            .foregroundStyle(.msWhite)
            .background(.red, in: .rect(cornerRadius: 8))
            .padding()
        }
    }
    
    private func sidebarItem(for screen: Screen) -> some View {
        Button {
            withAnimation(.smooth) {
                screenSelection = screen
            }
        } label: {
            Label(screen.id, systemImage: screen.iconName)
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity, minHeight: 30, alignment: .leading)
        .padding(.horizontal, 5)
        .foregroundStyle(screenSelection == screen ? .msWhite : .msDarkBlue)
        .background(screenSelection == screen ? .msPrimary : .clear, in: .rect(cornerRadius: 8))
    }
}
