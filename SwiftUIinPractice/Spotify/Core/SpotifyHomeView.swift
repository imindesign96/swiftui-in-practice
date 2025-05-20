//
//  SpotifyHomeView.swift
//  SwiftUIinPractice
//
//  Created by Phan Ngoc Vu on 2025/05/21.
//

import SwiftUI

struct SpotifyHomeView: View {
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders], content: {
                    Section {
                        ForEach(0..<20) { _ in
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: 200, height: 200)
                        }
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
                .padding(.horizontal, 10)
            }
            .scrollIndicators(.hidden)
            
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(.spotifyBlack)
        
    }
    
    private func getData() async {
        do {
            currentUser = try await DataBaseHelper().getUsers().first
        } catch {
            
        }
    }
    
}

#Preview {
    SpotifyHomeView()
}
