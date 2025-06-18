//
//  CachedAsyncImage.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 18/06/25.
//

import SwiftUI

/// A view that loads and displays an image from a URL, with built-in caching.
///
/// `CachedAsyncImage` wraps SwiftUI's `AsyncImage` and uses `ImageCache` to
/// store and reuse previously loaded images, reducing redundant network calls.
///
/// - Note: If an image is already cached, it is displayed immediately without
/// triggering a new network request.
struct CachedAsyncImage<Content>: View where Content: View {

    /// The URL of the image to load.
    private let url: URL?

    /// The image scale factor to apply.
    private let scale: CGFloat

    /// The transition to use when the image loads.
    private let transaction: Transaction

    /// The content builder for rendering different phases of image loading.
    private let content: (AsyncImagePhase) -> Content

    /// Initializes a new `CachedAsyncImage` instance.
    ///
    /// - Parameters:
    ///   - url: The image URL to load.
    ///   - scale: The scale factor to apply to the image.
    ///   - transaction: The transaction to apply to image transitions.
    ///   - content: A view builder that receives the loading phase and returns a view.
    init(
        url: URL?,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {
        if let url = self.url, let cached = ImageCache[url] {
            content(.success(cached))
        } else {
            AsyncImage(url: url, scale: scale, transaction: transaction) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }

    /// Caches the successfully loaded image and returns the corresponding view.
    ///
    /// - Parameter phase: The loading phase from `AsyncImage`.
    ///
    /// - Returns: A view based on the provided loading phase.
    private func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase, let url = self.url {
            ImageCache[url] = image
        }
        return content(phase)
    }
}

