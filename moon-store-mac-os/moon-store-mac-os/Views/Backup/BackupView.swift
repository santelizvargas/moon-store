//
//  BackupView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/5/25.
//

import SwiftUI

struct BackupView: View {
    @ObservedObject private var viewModel: BackupViewModel = .init()
    
    var body: some View {
        VStack {
            if viewModel.backupList.isEmpty {
                Text("No backups yet")
            } else {
                List(viewModel.backupList, id: \.self) { backup in
                    Text(backup)
                        .lineLimit(1)
                    
                }
            }
        }
        .screenSize()
        .showSpinner($viewModel.isLoading)
    }
}

#Preview {
    BackupView()
}
