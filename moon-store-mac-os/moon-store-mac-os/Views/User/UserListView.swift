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
        VStack {
            HStack {
                Text(localizedString(.user))
                    .leadingInfinity()
                    .font(.title3)
                    .bold()
                
                Button(localizedString(.inviteUser),
                       systemImage: UserConstants.Button.plusIcon) {
                    showModal.toggle()
                }
                .buttonStyle(.plain)
                .padding(UserConstants.padding)
                .foregroundStyle(.msWhite)
                .background(.msPrimary, in: .rect(cornerRadius: UserConstants.cornerRadius))
            }
            
            productTableView
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding(.horizontal)
        .sheet(isPresented: $showModal) {
            UserInviteView(isShowing: $showModal)
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
                        HStack(spacing: UserConstants.UserRow.hStackSpacing) {
                            userRowView(user: user)
                            .padding(.vertical)
                        }
                        .background(index % UserConstants.UserRow.evenNumber == .zero
                                    ? .msLightGray
                                    : .msWhite)
                    }
                }
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: UserConstants.cornerRadius)
                .stroke(.msGray)
            
            if viewModel.showEmptyView {
                MSEmptyListView {
                    viewModel.getUsers()
                }
            }
        }
        .clipShape(.rect(cornerRadius: UserConstants.cornerRadius))
        .showSpinner($viewModel.isLoading)
    }
    
    // MARK: - Header Table View
    
    private var headerTableView: some View {
        Grid {
            GridRow {
                ForEach(UserTableHeader.allCases) { title in
                    Text(title.title)
                        .frame(maxWidth: .infinity,
                               alignment: title == .role ? .center : .leading)
                        .foregroundStyle(.black)
                        .font(.body.bold())
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
        }
    }
    
    // MARK: - Table Row View
    
    private func userRowView(user: UserModel) -> some View {
        GridRow {
            Image(systemName: UserConstants.personIcon)
                .resizable()
                .frame(square: UserConstants.iconSize)
            
            Text("\(user.firstName) \(user.lastName)")
                .leadingInfinity()
                .foregroundStyle(.msBlack)
                .lineLimit(UserConstants.UserRow.lineLimit)
            
            Group {
                Text(user.email)
                    .lineLimit(UserConstants.UserRow.lineLimit)
                    .leadingInfinity()
                
                Text(user.roles.first?.name ?? "")
                
                Text(user.createdAt.formattedDate ?? localizedString(.invalidDate))
                    .frame(alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(.msDarkGray)
            
            optionsView
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - User options view
    
    private var optionsView: some View {
        HStack(spacing: UserConstants.UserRow.spacing) {
            Text(localizedString(.edit))
                .underline()
                .foregroundStyle(.msPrimary)
            
            Image(systemName: UserConstants.UserRow.trashIcon)
                .resizable()
                .frame(square: UserConstants.UserRow.iconSize)
                .foregroundStyle(.red)
        }
        .padding(.trailing)
    }
}

extension UserListView {
    private enum TitleValue {
        case header, user, inviteUser, edit, invalidDate
    }
    
    private func localizedString(_ key: TitleValue) -> String {
        switch key {
            case .header: "Vista General"
            case .user: "Usuarios agregados"
            case .inviteUser: "Invitar usuarios"
            case .edit: "Editar"
            case .invalidDate: "Fecha inválida"
        }
    }
}

#Preview {
    UserListView()
}
