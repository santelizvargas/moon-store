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
            headerView
            
            if viewModel.shouldShowEmptyView {
                MSEmptyListView {
                    viewModel.getBackupList()
                }
            } else {
                List(viewModel.backupList, id: \.self) { backup in
                    Text("\(localizedString(.rowPrefix)) \(backup)")
                        .frame(alignment: .center)
                        .lineLimit(Constants.lineLimit)
                }
                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
            }
        }
        .padding()
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
