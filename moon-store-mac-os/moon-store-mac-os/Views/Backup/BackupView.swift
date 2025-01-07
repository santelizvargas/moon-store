//
//  BackupView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/5/25.
//

import SwiftUI

private enum Constants {
    static let lineLimit: Int = 1
    static let listWidth: CGFloat = 400
    static let cornerRadius: CGFloat = 8
    static let buttonWidth: CGFloat = 200
}

struct BackupView: View {
    @ObservedObject private var viewModel: BackupViewModel = .init()
    
    var body: some View {
        VStack {
            headerView
            
            if viewModel.backupList.isEmpty, !viewModel.isLoading {
                MSEmptyListView {
                    viewModel.getBackupList()
                }
            } else {
                List(viewModel.backupList, id: \.self) { backup in
                    Text(backup)
                        .frame(alignment: .center)
                        .lineLimit(Constants.lineLimit)
                    
                }
                .frame(width: Constants.listWidth)
                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
            }
        }
        .padding()
        .screenSize()
        .showSpinner($viewModel.isLoading)
    }
    
    private var headerView: some View {
        HStack {
            Text(localizedString(.headerTitle))
                .font(.title)
                .leadingInfinity()
            
            PrimaryButton(localizedString(.addBackupButton)) {
                viewModel.showBackupConfirmationAlert()
            }
            .frame(width: Constants.buttonWidth)
        }
    }
}

// MARK: Localized

extension BackupView {
    private enum BackupViewKey {
        case headerTitle
        case addBackupButton
    }
    
    private func localizedString(_ key: BackupViewKey) -> String {
        switch key {
            case .headerTitle: "Backups"
            case .addBackupButton: "Backup base de datos"
        }
    }
}

#Preview {
    BackupView()
}
