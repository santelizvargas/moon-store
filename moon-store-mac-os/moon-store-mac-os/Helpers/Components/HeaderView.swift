//
//  HeaderView.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 23/12/24.
//

import SwiftUI

private enum Constants {
    static let iconSize: CGFloat = 30
}

struct HeaderView: View {
    private let title: String
    private let icon: String
    
    init(title: String, icon: String) {
        self.title = title
        self.icon = icon
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: icon)
                .resizable()
                .frame(width: Constants.iconSize, height: Constants.iconSize)
        }
        .padding(.vertical)
        .foregroundStyle(.black)
    }
}
