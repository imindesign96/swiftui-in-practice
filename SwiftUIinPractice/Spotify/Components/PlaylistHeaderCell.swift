//
//  PlaylistHeaderCell.swift
//  SwiftUIinPractice
//
//  Created by Phan Ngoc Vu on 2025/05/25.
//

import SwiftUI

struct PlaylistHeaderCell: View {
    
    var height: CGFloat = 300
    var title: String = "Some title"
    var subTitle: String = "Some sub title"
    var imageName: String = Contants.randomImage
    var shadowColor: Color = .spotifyBlack.opacity(0.8)
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(
                ImageLoaderView(urlString: imageName)
            )
            .overlay(
                VStack(alignment: .leading, spacing: 8) {
                    Text(subTitle)
                        .font(.headline)
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                    .foregroundStyle(.spotifyWhite)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(colors: [shadowColor.opacity(0.001),shadowColor], startPoint: .top, endPoint: .bottom)
                    )
                
                
                ,alignment: .bottomLeading
            )
            .asStretchyHeader(startingHeight: height)
            .frame(height: height)
    }
}

#Preview {
    
    ZStack {
        Color.black.ignoresSafeArea()
        
        ScrollView {
            PlaylistHeaderCell()
        }
        .ignoresSafeArea()
    }
}
