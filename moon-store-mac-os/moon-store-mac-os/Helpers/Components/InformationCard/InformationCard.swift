//
//  InformationCard.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 6/1/25.
//

import SwiftUI

struct InformationCard: View {
    private typealias Constants = InformationCardConstants
    private let info: Information
    
    init(info: Information) {
        self.info = info
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.titleSpacing) {
            header
            
            Text(info.description)
                .font(.caption)
        }
        .padding()
        .background(backgroundShapes)
        .background(info.color)
        .foregroundStyle(.msWhite)
        .clipShape(.rect(cornerRadius: Constants.cornerRadius))
    }
    
    var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: Constants.headerSpacing) {
                Text(info.title)
                    .font(.headline)
                
                Text(info.count.description)
                    .font(.title.bold())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: info.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: Constants.iconSize, height: Constants.iconSize)
                .padding(Constants.iconPadding)
                .background(
                    LinearGradient(
                        colors: [.clear, .msWhite.opacity(Constants.gradientOpacity)],
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing
                    )
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                )
                .overlay {
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .stroke(.msWhite)
                }
        }
    }
    
    var backgroundShapes: some View {
        ZStack(alignment: .bottomLeading) {
            Circle()
                .fill(.msGray.opacity(Constants.smallCircleOpacity))
                .frame(square: Constants.smallCircleSize)
                .offset(x: Constants.smallCircleOffsetX, y: Constants.smallCircleOffsetY)
            
            Circle()
                .fill(.msGray.opacity(Constants.largeCircleOpacity))
                .frame(square: Constants.largeCircleSize)
                .offset(x: Constants.largeCircleOffsetX, y: Constants.largeCircleOffsetY)
        }
        .leadingInfinity()
    }
}
