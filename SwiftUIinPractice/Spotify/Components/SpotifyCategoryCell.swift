//
//  SpotifyCategoryCell.swift
//  SwiftUIinPractice
//
//  Created by Phan Ngoc Vu on 2025/05/21.
//

import SwiftUI

struct SpotifyCategoryCell: View {
    
    var title: String = "Music"
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
            .cornerRadius(16)
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack(spacing: 40) {
            SpotifyCategoryCell(title: "All")
            SpotifyCategoryCell(title: "Hello", isSelected: true)
            SpotifyCategoryCell(title: "Hello")
        }


    }
}
