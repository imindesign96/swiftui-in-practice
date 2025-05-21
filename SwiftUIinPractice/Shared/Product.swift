//
//  Product.swift
//  SwiftUIinPractice
//
//  Created by Phan Ngoc Vu on 2025/05/20.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let price: Double
    let stock: Int
    let brand: String?
    let thumbnail: String
    
    let images: [String]
    
    var firstImage: String {
        images.first ?? Contants.randomImage
    }

}
