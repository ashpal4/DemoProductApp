//
//  ThumbnailImageView.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 18/06/25.
//

import SwiftUI

struct ThumbnailImageView: View {
    let imageUrl: String
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let imageCornerRadius: CGFloat
    
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
    
    var body: some View {
        CachedAsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure(_):
                Image(systemName: ImageName.defaultImage)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .padding(10)
            default:
                ProgressView()
            }
        }
        .frame(width: imageWidth, height: imageHeight)
        .cornerRadius(imageCornerRadius)
    }
}
