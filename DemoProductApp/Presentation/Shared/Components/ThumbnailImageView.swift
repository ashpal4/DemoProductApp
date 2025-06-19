//
//  ThumbnailImageView.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 18/06/25.
//

import SwiftUI

/// A view that displays a thumbnail image from a URL.
/// If the image fails to load, a default image is shown instead.
struct ThumbnailImageView: View {
    
    // MARK: - Properties
    
    /// The URL of the image to be displayed.
    let imageUrl: String
    
    /// The width of the thumbnail image.
    let imageWidth: CGFloat
    
    /// The height of the thumbnail image.
    let imageHeight: CGFloat
    
    /// The corner radius to apply to the image for rounded corners.
    let imageCornerRadius: CGFloat
    
    // MARK: - Initialization
    
    /// Initializes a `ThumbnailImageView` with the given parameters.
    ///
    /// - Parameters:
    ///   - imageUrl: The URL of the image to display.
    ///   - imageWidth: The width of the image. Defaults to 60.
    ///   - imageHeight: The height of the image. Defaults to 60.
    ///   - imageCornerRadius: The corner radius to round the image. Defaults to 80.
    init(
        imageUrl: String,
        imageWidth: CGFloat = 60,
        imageHeight: CGFloat = 60,
        imageCornerRadius: CGFloat = 80
    ) {
        self.imageUrl = imageUrl
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.imageCornerRadius = imageCornerRadius
    }
    
    // MARK: - Body
    
    var body: some View {
        // Displays the image from the URL using a cached async image loader.
        CachedAsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .success(let image):
                // On success, display the image with resizing and scaling.
                image
                    .resizable()
                    .scaledToFit()
            case .failure(_):
                // On failure (e.g., image URL is invalid or fails to load), display a default image.
                Image(systemName: ImageName.defaultImage)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .padding(10)
            default:
                // Show a loading spinner while the image is being fetched.
                ProgressView()
            }
        }
        // Set the frame size and corner radius for the image.
        .frame(width: imageWidth, height: imageHeight)
        .cornerRadius(imageCornerRadius)
    }
}
