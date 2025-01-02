//
//  MemoryCache.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//

import Foundation

final class MemoryCache<Key: Hashable, Value> {
    private let cache = NSCache<CacheKey, CacheValue>()

    // MARK: - Cache Value

    private final class CacheValue {
        let value: Value

        init(_ value: Value) {
            self.value = value
        }
    }

    // MARK: - Cache Key

    private final class CacheKey: NSObject {
        let key: Key

        init(_ key: Key) {
            self.key = key
        }

        override func isEqual(_ object: Any?) -> Bool {
            guard let other = object as? CacheKey else { return false }
            return key == other.key
        }

        override var hash: Int { key.hashValue }
    }

    // MARK: - Subscript

    subscript(_ key: Key) -> Value? {
        get {
            cache.object(forKey: CacheKey(key))?.value
        }
        set {
            let cacheKey = CacheKey(key)

            if let newValue {
                cache.setObject(CacheValue(newValue), forKey: cacheKey)
            } else {
                cache.removeObject(forKey: cacheKey)
            }
        }
    }
}
