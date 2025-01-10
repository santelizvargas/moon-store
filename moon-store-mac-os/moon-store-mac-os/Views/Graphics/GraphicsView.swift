//
//  GraphicsView.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 6/1/25.
//

import SwiftUI

private enum Constants {
    static let mainSpacing: CGFloat = 20
}

struct GraphicsView: View {
    var body: some View {
        VStack(spacing: Constants.mainSpacing) {
            HStack {
                ForEach(Information.mockInfo) { info in
                    InformationCard(info: info)
                }
            }
            
            BarChart(
                title: "Productos mas vendidos",
                data: ChartData.topSellingProducts,
                color: .msPrimary,
                titleAlignment: .center
            )
            
            HStack(spacing: Constants.mainSpacing) {
                AreaChart(
                    title: "Productos Vendidos",
                    data: ChartData.products,
                    color: .msPrimary
                )
                
                AreaChart(
                    title: "Facturas Generadas",
                    data: ChartData.invoices,
                    color: .msGreen
                )
            }
        }
        .padding()
    }
}
