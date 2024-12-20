//
//  moon_store_mac_osApp.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 11/16/24.
//

import SwiftUI

@main
struct moon_store_mac_osApp: App {
    @StateObject private var router: AppRouter = .init()
    
    var body: some Scene {
        WindowGroup {
            InitialView()
                .preferredColorScheme(.light)
                .environmentObject(router)
        }
    }
}
