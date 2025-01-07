//
//  GraphicsView.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 6/1/25.
//

import SwiftUI

struct GraphicsView: View {
    var body: some View {
        VStack {
            HStack {
                ForEach(Information.mockInfo) { info in
                    InformationCard(info: info)
                }
            }
            
            Spacer() // Remove this spacer when other views are added
        }
        .padding()
    }
}
