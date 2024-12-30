//
//  UserConstants.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 30/12/24.
//

import SwiftUI

enum UserConstants {
    static let cornerRadius: CGFloat = 10
    static let iconSize: CGFloat = 30
    static let personIcon: String = "person.crop.circle.fill"
    static let padding: CGFloat = 10
    static let textFieldHeight: CGFloat = 40
    
    enum Button {
        static let plusIcon: String = "paperplane.fill"
    }
    
    enum UserRow {
        static let spacing: CGFloat = 10
        static let trashIcon: String = "trash"
        static let iconSize: CGFloat = 20
        static let hStackSpacing: CGFloat = -30
        static let lineLimit: Int = 1
        static let evenNumber: Int = 2
    }
    
    enum Alert {
        static let iconSize: CGFloat = 16
        static let iconTitle: String = "xmark.circle.fill"
        static let placeholder: String = "example@example.com"
        static let height: CGFloat = 120
        static let verticalpadding: CGFloat = 5
        static let buttonHeight: CGFloat = 100
    }
}
