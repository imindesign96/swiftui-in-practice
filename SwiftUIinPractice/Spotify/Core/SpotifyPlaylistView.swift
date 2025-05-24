//
//  SpotifyPlaylistView.swift
//  SwiftUIinPractice
//
//  Created by Phan Ngoc Vu on 2025/05/25.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlaylistView: View {
    
    @Environment(\.router) var router

    let product: Product = .mock
    let user: User = .mock
    
    @State private var products: [Product] = []
//    @State private var productRow: [ProductRow] = []
    @State private var showHeader: Bool = true
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    PlaylistHeaderCell(
                        height: 250,
                        title: product.title,
                        subTitle: product.description,
                        imageName: product.thumbnail
                    )
                    .readingFrame { frame in
                        showHeader = frame.maxY < 150
                    }
                    
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        userName: user.username,
                        subheadline: product.category,
                        onAddToPlaylistPressed: nil,
                        onDownloadPressed: nil,
                        onSharePressed: nil,
                        onEllipsisPressed: nil,
                        onShufflePressed: nil,
                        onPlayPressed: nil
                    )
                    
                    
                    ForEach(products) { product in
                        SongRowCell(
                            imageSize: 50,
                            imageName: product.firstImage,
                            title: product.title,
                            subtitle: product.brand,
                            onCellPressed: {
//                                goToPlaylistView(product: product)
                            },
                            onEllipsisPressed: {
                                
                            }
                        )
                        .padding(.leading, 16)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
        
    }
    
//    private func goToPlaylistView(product: Product) {
//        router.showScreen(.push) { _ in
//            SpotifyPlaylistView(product: product, user: user)
//        }
//    }
    
    private func getData() async {
        do {
            products = try await DataBaseHelper().getProducts()
            
        } catch {
            
        }
    }
    
}

#Preview {
    SpotifyPlaylistView()
}
