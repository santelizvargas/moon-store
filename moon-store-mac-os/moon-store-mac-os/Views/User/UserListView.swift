//
//  UserListView.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 23/12/24.
//

import SwiftUI

private enum Constants {
    static let cornerRadius: CGFloat = 10
    static let iconSize: CGFloat = 30
    static let personIcon: String = "person.crop.circle.fill"
    static let headerTitle: String = "Vista General"
    static let userTitle: String = "Usuarios agregados"
    static let padding: CGFloat = 10
    static let textFieldHeight: CGFloat = 40
    
    enum Button {
        static let title: String = "Invitar usuarios"
        static let plusIcon: String = "paperplane.fill"
    }
    
    enum UserRow {
        static let spacing: CGFloat = 10
        static let editTitle: String = "Edit"
        static let trashIcon: String = "trash"
        static let iconSize: CGFloat = 20
        static let hStackSpacing: CGFloat = -30
        static let lineLimit: Int = 1
        static let evenNumber: Int = 2
    }
    
    enum Alert {
        static let iconSize: CGFloat = 16
        static let title: String = "Dirección de correo:"
        static let buttonTitle: String = "Invitar"
        static let iconTitle: String = "xmark.circle.fill"
        static let placeholder: String = "example@example.com"
        static let height: CGFloat = 120
        static let verticalpadding: CGFloat = 5
        static let buttonHeight: CGFloat = 100
    }
}

enum UserTableHeader: CaseIterable {
    case icon, user, email, role, date, option
    
    var title: String {
        switch self {
            case .user: "Usuario"
            case .email: "Email"
            case .role: "Rol"
            case .date: "Fecha"
            default: ""
        }
    }
}

struct UserListView: View {
    @State private var showActionSheet: Bool = false
    
    var body: some View {
        VStack {
            HeaderView(
                title: Constants.headerTitle,
                icon: Constants.personIcon
            )
            
            HStack {
                Text(Constants.userTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title3)
                    .bold()
                
                Button {
                    showActionSheet.toggle()
                } label: {
                    Label(Constants.Button.title,
                          systemImage: Constants.Button.plusIcon)
                    .foregroundStyle(.msWhite)
                }
                .buttonStyle(.plain)
                .padding(Constants.padding)
                .background(.msPrimary, in: .rect(cornerRadius: Constants.cornerRadius))
            }
            
            productTableView
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding(.horizontal)
        .sheet(isPresented: $showActionSheet) {
            UserInviteView(isShowing: $showActionSheet)
        }
    }
    
    // MARK: - Table View
    
    private var productTableView: some View {
        VStack(spacing: .zero) {
            headerTableView
                .background(.msWhite)
            
            ScrollView(showsIndicators: false) {
                Grid(horizontalSpacing: .zero, verticalSpacing: .zero) {
                    ForEach(Array(UserModel.userMockData.enumerated()), id: \.element.id) { index, user in
                        HStack(spacing: Constants.UserRow.hStackSpacing) {
                            productRowView(
                                userName: "\(user.firstName) \(user.lastName)",
                                email: user.email,
                                role: user.roles.first?.name ?? "",
                                date: user.createdAt
                            )
                            .padding(.vertical)
                        }
                        .background(index % Constants.UserRow.evenNumber == .zero
                                    ? .msLightGray
                                    : .msWhite)
                    }
                }
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(.msGray)
        }
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
    }
    
    // MARK: - Header Table View
    
    private var headerTableView: some View {
        Grid {
            GridRow {
                ForEach(UserTableHeader.allCases, id: \.self) { title in
                    Text(title.title)
                        .frame(maxWidth: .infinity,
                               alignment: title == .role ? .center : .leading)
                        .foregroundStyle(.black)
                        .font(.body)
                        .bold()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
        }
    }
    
    // MARK: - Table Row View
    
    private func productRowView(userName: String, email: String, role: String, date: String) -> some View {
        GridRow {
            Image(systemName: Constants.personIcon)
                .resizable()
                .frame(width: Constants.iconSize,
                       height: Constants.iconSize)
            
            Text(userName)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .foregroundStyle(.black)
                .lineLimit(Constants.UserRow.lineLimit)
            
            Group {
                Text(email)
                    .lineLimit(Constants.UserRow.lineLimit)
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                
                Text(role)
                    .frame(alignment: .center)
                
                Text(date)
                    .frame(alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(.msDarkGray)
            
            opctionsView
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Product options view
    
    private var opctionsView: some View {
        HStack(spacing: Constants.UserRow.spacing) {
            Text(Constants.UserRow.editTitle)
                .underline()
                .foregroundStyle(.msPrimary)
            
            Image(systemName: Constants.UserRow.trashIcon)
                .resizable()
                .frame(width: Constants.UserRow.iconSize,
                       height: Constants.UserRow.iconSize)
                .foregroundStyle(.red)
        }
        .padding(.trailing)
    }
}

#Preview {
    UserListView()
}
