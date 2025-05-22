//
//  ImageTitleRowCell.swift
//  SwiftUIinPractice
//
//  Created by Phan Ngoc Vu on 2025/05/23.
//

import SwiftUI

struct ImageTitleRowCell: View {
    var imageSize: Double = 100
    var imageName: String = Contants.randomImage
    var title: String = "Some new Title"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.spotifyLightGray)
                .lineLimit(2)
                .padding(4)
        }
        .frame(width: imageSize)
    }
}

#Preview {
    
    ZStack {
        Color.black.ignoresSafeArea()
        ImageTitleRowCell()
    }
}
