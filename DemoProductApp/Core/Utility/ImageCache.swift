//
//  ImageCache.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 18/06/25.
//

import SwiftUI

/// A basic in-memory image cache using a static dictionary.
///
/// `ImageCache` stores SwiftUI `Image` instances keyed by their corresponding `URL`s.
/// It is used to avoid re-downloading images during list scrolling or navigation.
final class ImageCache {

    /// The underlying image storage.
    static private var cache: [URL: Image] = [:]

    /// Accesses the image for a given URL.
    ///
    /// - Parameter url: The URL used as the cache key.
    ///
    /// - Returns: The cached `Image`, or `nil` if not present.
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
