//
//  ImageCache.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//


import SwiftUI

final class ImageCache {
    static let shared: ImageCache = .init()
    private let imageCache = MemoryCache<String, Image>()
    
    private init() { }
    
    @discardableResult
    func addImage(_ image: Image, with url: String) -> Image {
        imageCache[url] = image
        return image
    }
    
    func getImage(from url: String) -> Image? {
        imageCache[url]
    }
}