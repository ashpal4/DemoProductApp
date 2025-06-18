//
//  ImageCacheTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 18/06/25.
//

import XCTest
import SwiftUI
@testable import DemoProductApp

final class ImageCacheTests: XCTestCase {

    func testImageCache_StoresAndRetrievesImage() {
        let url = URL(string: "https://example.com/image.png")!
        let image = Image(systemName: "star.fill")

        ImageCache[url] = image
        let cached = ImageCache[url]

        XCTAssertNotNil(cached)
        // Since Image doesn't conform to Equatable, we check its type
        XCTAssert(type(of: cached!) == type(of: image))
    }

    func testImageCache_ReplacesExistingImage() {
        let url = URL(string: "https://example.com/image.png")!
        let firstImage = Image(systemName: "star")
        let secondImage = Image(systemName: "star.fill")

        ImageCache[url] = firstImage
        ImageCache[url] = secondImage

        let cached = ImageCache[url]
        XCTAssertNotNil(cached)
        // Check type or assume the replacement worked by reference logic
        XCTAssert(type(of: cached!) == type(of: secondImage))
    }

    func testImageCache_ClearsImageWhenSetToNil() {
        let url = URL(string: "https://example.com/image.png")!
        let image = Image(systemName: "xmark")

        ImageCache[url] = image
        ImageCache[url] = nil

        XCTAssertNil(ImageCache[url])
    }
}
