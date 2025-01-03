//
//  MSImagePickerViewModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//

import Foundation
import _PhotosUI_SwiftUI
import SwiftUI

final class MSImagePickerViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem?
    @Published var selectedImage: Image?
    
    func loadImage() {
        guard let selectedItem else { return }
        
        Task { @MainActor in
            do {
                selectedImage = try await loadAsyncImage(from: selectedItem)
            } catch {
                AlertPresenter.showAlert(with: error)
            }
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
