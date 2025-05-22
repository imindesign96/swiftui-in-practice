//
//  SpotifyHomeView.swift
//  SwiftUIinPractice
//
//  Created by Phan Ngoc Vu on 2025/05/21.
//

import SwiftUI
import SwiftfulUI

struct SpotifyHomeView: View {
    @State private var currentUser: User? = nil
    @State private var products: [Product] = []
    @State private var selectedCategory: Category? = nil
    @State private var productRows: [ProductRow] = []

    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(
                    spacing: 2,
                    pinnedViews: [.sectionHeaders],
                    content: {
                        Section {
                            recentsCell
                                .padding(.horizontal, 16)
                                .padding(.bottom, 16)

                            
                            if let product = products.first {
                                newReleaseCell(product: product)
                                    .padding(.horizontal, 16)
                            }
                            
                            listRows
                            
                        } header: {
                            header
                        }
                    })
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await getData()
        }
    }
    
    private var recentsCell: some View {
        NonLazyVGrid(
            columns: 2,
            alignment: .center,
            spacing: 10,
            items: products,
            content: { product in
                if let product {
                    SpotifyRecentsCell(
                        imageName: product.firstImage,
                        title: product.title
                    )
                    .asButton(.press) {
                        print("presed: \(product.title)")
                    }
                }
            }
        )
    }
    
    private func newReleaseCell(product: Product) -> some View {
        SpotifyNewReleaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            subHeadline: product.category,
            title: product.title,
            description: product.description,
            onAddToPlaylistPressed: {
                print("onAddToPlaylistPressed: \(product.title)")
            },
            onPlayPressed: {
                print("onPlayPressed: \(product.title)")
            }
        )
    }
    
    private var listRows: some View {
        ForEach(productRows) { row in
            VStack(spacing: 2) {
                Text(row.title)
                           .font(.title)
                           .fontWeight(.semibold)
                           .foregroundStyle(.spotifyWhite)
                           .frame(maxWidth: .infinity, alignment: .leading)
                           .padding(.horizontal, 16)
                           .padding(.top, 8)

                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(products) { product in
                            ImageTitleRowCell(
                                imageSize: 120,
                                imageName: product.firstImage,
                                title: product.title
                            )
                            .asButton(.press) {
                                print("onPlayPressed: \(product.title)")
                            }
                        }

                    }

                }
//                .background(Color.red)
                .scrollIndicators(.hidden)

            }
            .padding(.horizontal, 8)
        }
        
    }

    
    private var header: some View {
        HStack(spacing: 0) {
            ZStack {
                if let currentUser = currentUser {
                    ImageLoaderView(urlString: currentUser.image).background(.spotifyWhite).clipShape(Circle())
                        .onTapGesture {
                            print("tap")
                        }
                }
            }
            .frame(width: 35, height: 35)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.uppercased(),
                            isSelected: category == selectedCategory)
                        
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                    
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
            
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .frame(maxWidth: .infinity)
        .background(.spotifyBlack)
        
    }
    
    private func getData() async {
        do {
            currentUser = try await DataBaseHelper().getUsers().first
            products = try await Array(DataBaseHelper().getProducts().prefix(8))
            
            var rows: [ProductRow] = []
            
            let allBrands = Set(products.map({ $0._brand }))
            for brand in allBrands {
//                let products = self.products.filter({ $0.brand == brand })
                rows.append(ProductRow(title: brand.capitalized, products: products))
            }
            productRows = rows
            
        } catch {
            
        }
    }
    
}

#Preview {
    SpotifyHomeView()
}
