//
//  ProductsListView.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import SwiftUI

struct ProductsListView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    @StateObject private var viewModel: ProductsListViewModel
    
    init(viewModel: ProductsListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List(viewModel.products) { product in
            Button {
                coordinator.push(.productDetail(product: product))
            } label: {
                HStack {
                    ThumbnailImageView(imageUrl: product.thumbnail)
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
