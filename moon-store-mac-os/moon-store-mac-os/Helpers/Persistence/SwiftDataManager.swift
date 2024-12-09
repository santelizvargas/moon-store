//
//  SwiftDataManager.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 6/12/24.
//

import Foundation
import SwiftData

// MARK: - SwiftData Manager

final class DataManager<Model: PersistentModel> {
    private lazy var context: ModelContext = {
        SwiftDataProvider.shared.context
    }()
    
    // MARK: - Methods

    func save(model: Model) {
        context.insert(model)
    }
    
    func fetch(predicate: Predicate<Model> = .true) throws -> [Model] {
        do {
            let descriptor = FetchDescriptor(predicate: predicate)
            return try context.fetch(descriptor)
        } catch {
            throw SwiftDataError.fetchModels
        }
    }
    
    func removeAll() throws {
        do {
            try context.delete(model: Model.self)
        } catch {
            throw SwiftDataError.removeModel
        }
    }
    
    func remove(model: Model) {
        context.delete(model)
    }
}
