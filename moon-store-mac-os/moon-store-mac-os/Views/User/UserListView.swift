//
//  UserListView.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 23/12/24.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel: UserListViewModel = .init()
    @State private var showModal: Bool = false
    
    var body: some View {
        VStack(spacing: UserConstants.spacing) {
            headerView
            productTableView
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding()
        .showSpinner($viewModel.isLoading)
        .sheet(isPresented: $showModal) {
            InviteUserView()
        }
    }
    
    // MARK: - Header View
    
    private var headerView: some View {
        HStack {
            Text(localizedString(.user))
                .font(.title3.bold())
                .leadingInfinity()
            
            Button(
                localizedString(.inviteUser),
                systemImage: UserConstants.Button.plusIcon
            ) {
                showModal.toggle()
            }
            .buttonStyle(.plain)
            .padding(UserConstants.padding)
            .foregroundStyle(.msWhite)
            .background(.msPrimary, in: .rect(cornerRadius: UserConstants.cornerRadius))
            
            ExporterButton(
                title: "Exportar Usuarios",
                fileName: "Usuarios",
                collection: viewModel.userList
            )
            .disabled(viewModel.cannotExportList)
        }
    }
    
    // MARK: - Table View
    
    private var productTableView: some View {
        VStack(spacing: .zero) {
            headerTableView
                .background(.msWhite)
            
            ScrollView(showsIndicators: false) {
                Grid(horizontalSpacing: .zero, verticalSpacing: .zero) {
                    ForEach(Array(viewModel.userList.enumerated()), id: \.element.id) { index, user in
                        userRowView(user: user, isEvenRow: index.isMultiple(of: UserConstants.UserRow.evenNumber))
                    }
                }
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .overlay {
            RoundedRectangle(cornerRadius: UserConstants.cornerRadius)
                .stroke(.msGray)
        }
        .clipShape(.rect(cornerRadius: UserConstants.cornerRadius))
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    // MARK: - Header Table View
    
    private var headerTableView: some View {
        Grid(horizontalSpacing: .zero, verticalSpacing: .zero) {
            GridRow {
                ForEach(UserTableHeader.allCases) { header in
                    Text(header.title)
                        .padding(header.padding)
                        .frame(
                            maxWidth: header == .option ? UserConstants.UserRow.optionSize : .infinity,
                            alignment: header.aligment
                        )
                        .foregroundStyle(.msBlack)
                        .font(.body.bold())
                }
            }
            .frame(height: UserConstants.UserRow.height)
        }
    }
    
    // MARK: - Table Row View
    
    private func userRowView(user: UserModel, isEvenRow: Bool) -> some View {
        GridRow {
            HStack(spacing: UserConstants.UserRow.spacing) {
                let fullName: String = "\(user.firstName) \(user.lastName)"
                
                Text(fullName.abbreviated)
                    .frame(square: UserConstants.iconSize)
                    .background(.msPrimary, in: .circle)
                    .foregroundStyle(.msWhite)
                
                Text(fullName)
                    .leadingInfinity()
                    .foregroundStyle(.msBlack)
                    .lineLimit(UserConstants.UserRow.lineLimit)
            }
            .padding(.leading)
            .frame(maxWidth: .infinity)
            
            Group {
                Text(user.email)
                    .lineLimit(UserConstants.UserRow.lineLimit)
                    .leadingInfinity()
                
                Text(user.roles.first?.name ?? "")
                
                Text(user.createdAt)
                    .frame(alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(.msDarkGray)
            
            optionsView(for: user)
        }
        .frame(height: UserConstants.UserRow.height)
        .background(isEvenRow ? .msLightGray : .msWhite)
    }
    
    // MARK: - User options view
    
    private func optionsView(for user: UserModel) -> some View {
        HStack(spacing: UserConstants.UserRow.spacing) {
            Menu(Role.getRole(from: user.roles.first).title) {
                ForEach(user.roles.first?.getRoles() ?? []) { role in
                    Button(role.title) {
                        viewModel.assignRole(role: role.name,
                                             email: user.email,
                                             revoke: user.roles.first?.id)
                    }
                }
            }
            
            Button {
                user.deletedAt == nil
                ? viewModel.showDisableUserConfirmationAlert(for: user.id)
                : viewModel.showEnableUserConfirmationAlert(for: user.id)
            } label: {
                Image(systemName: user.deletedAt == nil
                      ? UserConstants.UserRow.trashIcon
                      : UserConstants.UserRow.reloadIcon)
                    .resizable()
                    .frame(square: UserConstants.UserRow.iconSize)
                    .foregroundStyle(.red)
            }
            .buttonStyle(.plain)
        }
    }
}

extension UserListView {
    private enum TitleValue {
        case header, user, inviteUser, edit
    }
    
    private func localizedString(_ key: TitleValue) -> String {
        switch key {
            case .header: "Vista General"
            case .user: "Usuarios agregados"
            case .inviteUser: "Invitar usuarios"
            case .edit: "Editar Roles"
        }
    }
}
