//
//  MSImagePickerViewModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//

import PhotosUI
import SwiftUI

final class MSImagePickerViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem?
    
    func loadImage() async -> Image? {
        guard let selectedItem else { return nil }
        
        do {
            return try await loadAsyncImage(from: selectedItem)
        } catch {
            AlertPresenter.showAlert(with: error)
            return nil
        }
    }
    
    private func loadAsyncImage(from item: PhotosPickerItem) async throws -> Image {
        do {
            guard let image = try await item.loadTransferable(type: Image.self)
            else { throw MSError.unsupportedFormat }
            return image
        } catch {
            throw MSError.invalidSelection
        }
    }
}
