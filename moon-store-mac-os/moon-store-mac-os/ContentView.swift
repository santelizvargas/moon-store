//
//  ContentView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 11/16/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .frame(maxWidth: 600, maxHeight: 400)
    }
}

#Preview {
    ContentView()
}
