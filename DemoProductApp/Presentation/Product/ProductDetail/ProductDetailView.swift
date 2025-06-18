//
//  ProductDetailView.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import SwiftUI

struct ProductDetailView: View {
    @StateObject var viewModel: ProductDetailViewModel
    
    init(viewModel: ProductDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: SizeConstants.productDetailSpacing) {
                ThumbnailImageView(
                    imageUrl: viewModel.thumbnail,
                    imageWidth: SizeConstants.productDetailImageHeight,
                    imageHeight: SizeConstants.productDetailImageHeight,
                    imageCornerRadius: SizeConstants.productDetailImageCornerRadius
                )
                titleView(title: viewModel.title)
                descriptionView(description: viewModel.description)
            }
            .padding()
        }
        .navigationTitle(StringConstants.productDetailTitle)
    }
}

extension ProductDetailView {
    func titleView(title: String) -> some View {
        Text(title)
            .font(.title)
    }
    
    func priceView(price: Double) -> some View {
        Text(price.currencyFormatted())
            .font(.headline)
    }
    
    func descriptionView(description: String) -> some View {
        Text(description)
            .font(.body)
    }
}
