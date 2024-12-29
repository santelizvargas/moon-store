//
//  AppTransition.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 9/12/24.
//

enum AppTransition: Hashable {
    case login
    case main(UserModel)
}
