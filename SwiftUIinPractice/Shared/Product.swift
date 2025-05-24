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
    let price: Double // Double not Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand: String? // <- Optional
    let category: String
    let thumbnail: String
    
    let images: [String]
    
    var firstImage: String {
        images.first ?? Contants.randomImage
    }
    
    var _brand: String {
        brand ?? ""
    }
    
    static var mock: Product {
        Product(
            id: 123,
            title: "Example product title",
            description: "This is some mock product description that goes here.",
            price: 999,
            discountPercentage: 15,
            rating: 4.5,
            stock: 50,
            brand: "Apple",
            category: "Electric Devices",
            thumbnail: Contants.randomImage,
            images: [Contants.randomImage,Contants.randomImage,Contants.randomImage]
        )
    }

}


struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}
