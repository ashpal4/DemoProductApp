//
//  ProductsListView.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import SwiftUI

struct ProductsListView: View {
    @ObservedObject var viewModel: ProductsListViewModel
    @EnvironmentObject private var coordinator: AppCoordinator

    var body: some View {
        List(viewModel.products) { product in
            Button {
                coordinator.push(.productDetail(product: product))
            } label: {
                HStack {
                    thumbnailView(name: product.thumbnail)
                    VStack(alignment: .leading) {
                        titleView(title: product.title)
                        priceView(price: product.price)
                    }
                }
            }
        }
        .onAppear {
            if viewModel.products.isEmpty {
                viewModel.loadProducts()
            }
        }
        .overlay {
            overlayView
        }
        .navigationTitle(StringConstants.productsListTitle)
    }
}

extension ProductsListView {
    enum SizeConstants {
        static let imageWidth: CGFloat = 60
        static let imageCornerRadius: CGFloat = 8
    }
    
    func thumbnailView(name: String) -> some View {
        CachedAsyncImage(url: URL(string: name)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure(_):
                Color.red
            default:
                ProgressView()
            }
        }
        .frame(width: SizeConstants.imageWidth)
        .cornerRadius(SizeConstants.imageCornerRadius)
    }
    
    func titleView(title: String) -> some View {
        Text(title)
    }
    
    func priceView(price: Double) -> some View {
        Text(price.currencyFormatted())
            .font(.subheadline)
            .foregroundColor(.gray)
    }
    
    @ViewBuilder
    var overlayView: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if let error = viewModel.errorMessage {
            Text(error)
                .foregroundColor(.red)
                .padding()
        }
    }
}
