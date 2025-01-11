//
//  BackupView.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/5/25.
//

import SwiftUI

private enum Constants {
    static let lineLimit: Int = 1
    static let cornerRadius: CGFloat = 8
    static let buttonWidth: CGFloat = 200
}

struct BackupView: View {
    @StateObject private var viewModel: BackupViewModel = .init()
    
    var body: some View {
        VStack {
            PrimaryButton(localizedString(.addBackupButton)) {
                viewModel.showBackupConfirmationAlert()
            }
            .frame(width: Constants.buttonWidth)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            if viewModel.backupList.isNotEmpty {
                List(viewModel.backupList, id: \.self) { backup in
                    Text("\(localizedString(.rowPrefix)) \(backup)")
                        .lineLimit(Constants.lineLimit)
                }
                .clipShape(.rect(cornerRadius: Constants.cornerRadius))
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .background {
            if viewModel.shouldShowEmptyView {
                MSEmptyListView {
                    viewModel.getBackupList()
                }
            }
        }
        .showSpinner($viewModel.isLoading)
    }
}

// MARK: Localized

extension BackupView {
    private enum BackupViewKey {
        case headerTitle
        case addBackupButton
        case rowPrefix
    }
    
    private func localizedString(_ key: BackupViewKey) -> String {
        switch key {
            case .headerTitle: "Respaldo"
            case .addBackupButton: "Respaldar base de datos"
            case .rowPrefix: "Nombre del respaldo: "
        }
    }
}

#Preview {
    BackupView()
}
