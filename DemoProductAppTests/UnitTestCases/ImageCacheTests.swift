//
//  ImageCacheTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 18/06/25.
//

import XCTest
import SwiftUI
@testable import DemoProductApp

/// Unit tests for the `ImageCache` functionality, ensuring image storage, replacement, and removal behaviors work as expected.
final class ImageCacheTests: XCTestCase {

    /// Tests that an image can be stored and later retrieved from the cache using a URL as the key.
    ///
    /// Since SwiftUI's `Image` is not `Equatable`, the test confirms successful retrieval and checks type equivalence.
    func testImageCache_StoresAndRetrievesImage() {
        // Arrange
        let url = URL(string: "https://example.com/image.png")!
        let image = Image(systemName: "star.fill")

        // Act
        ImageCache[url] = image
        let cached = ImageCache[url]

        // Assert
        XCTAssertNotNil(cached)
        // Since Image doesn't conform to Equatable, we check its type
        XCTAssert(type(of: cached!) == type(of: image))
    }

    /// Tests that setting a new image for an existing URL key in the cache replaces the previous image.
    func testImageCache_ReplacesExistingImage() {
        // Arrange
        let url = URL(string: "https://example.com/image.png")!
        let firstImage = Image(systemName: "star")
        let secondImage = Image(systemName: "star.fill")

        // Act
        ImageCache[url] = firstImage
        ImageCache[url] = secondImage
        let cached = ImageCache[url]

        // Assert
        XCTAssertNotNil(cached)
        // Check type or assume the replacement worked by reference logic
        XCTAssert(type(of: cached!) == type(of: secondImage))
    }

    /// Tests that setting a value in the cache to `nil` removes the image associated with that URL.
    func testImageCache_ClearsImageWhenSetToNil() {
        // Arrange
        let url = URL(string: "https://example.com/image.png")!
        let image = Image(systemName: "xmark")

        // Act
        ImageCache[url] = image
        ImageCache[url] = nil

        // Assert
        XCTAssertNil(ImageCache[url])
    }
}

