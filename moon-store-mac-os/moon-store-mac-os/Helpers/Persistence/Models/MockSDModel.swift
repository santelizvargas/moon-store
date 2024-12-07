//
//  MockSDModel.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 6/12/24.
//

import SwiftData

@Model
final class MockSDModel: Identifiable, PersistentModel {
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
