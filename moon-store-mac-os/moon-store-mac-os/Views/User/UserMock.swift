//
//  UserMock.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 23/12/24.
//

import Foundation

extension UserModel {
    static let userMockData: [UserModel] = [
        UserModel(
            id: 1,
            firstName: "John",
            lastName: "Doe",
            email: "johndoe@example.com",
            identification: "1234567890",
            phone: "555-1234",
            address: "123 Main St, Springfield",
            roles: [RoleModel(id: 1, name: "Admin", desc: "")],
            createdAt: "01 Enero 2024",
            updatedAt: "2024-01-02T12:00:00Z",
            deletedAt: nil
        ),
        UserModel(
            id: 2,
            firstName: "Jane",
            lastName: "Smith",
            email: "janesmith@example.com",
            identification: "9876543210",
            phone: "555-5678",
            address: "456 Elm St, Metropolis",
            roles: [RoleModel(id: 2, name: "User", desc: "")],
            createdAt: "01 Marzo 2024",
            updatedAt: nil,
            deletedAt: nil
        ),
        UserModel(
            id: 3,
            firstName: "Alice",
            lastName: "Johnson",
            email: "alicej@example.com",
            identification: "1122334455",
            phone: "555-7890",
            address: "789 Pine St, Gotham",
            roles: [RoleModel(id: 3, name: "Editor", desc: "")],
            createdAt: "05 Abril 2024",
            updatedAt: "2024-01-05T10:00:00Z",
            deletedAt: nil
        ),
        UserModel(
            id: 4,
            firstName: "Bob",
            lastName: "Brown",
            email: "bobbrown@example.com",
            identification: "5566778899",
            phone: "555-2345",
            address: "101 Maple St, Star City",
            roles: [RoleModel(id: 4, name: "Viewer", desc: "")],
            createdAt: "15 Marzo 2024",
            updatedAt: nil,
            deletedAt: nil
        ),
        UserModel(
            id: 5,
            firstName: "Charlie",
            lastName: "Davis",
            email: "charlied@example.com",
            identification: "2233445566",
            phone: "555-3456",
            address: "202 Birch St, Central City",
            roles: [RoleModel(id: 5, name: "User", desc: "")],
            createdAt: "22 Junio 2024",
            updatedAt: "2024-01-07T09:00:00Z",
            deletedAt: "2024-01-08T08:00:00Z"
        )
    ]
}
