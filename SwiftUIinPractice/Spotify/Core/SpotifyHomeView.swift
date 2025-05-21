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
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(
                    spacing: 1,
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
                        } header: {
                            header
                        }
                    })
                .padding(.top, 8)
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
            headline: product.title,
            subHeadline: product.title,
            title: product.title,
            description: product.title,
            onAddToPlaylistPressed: {
                
            },
            onPlayPressed: {
                
            }
        )
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
        } catch {
            
        }
    }
    
}

#Preview {
    SpotifyHomeView()
}
