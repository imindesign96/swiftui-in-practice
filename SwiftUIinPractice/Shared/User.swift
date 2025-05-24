//
//  User.swift
//  SwiftUIinPractice
//
//  Created by Phan Ngoc Vu on 2025/05/20.
//


import Foundation

// MARK: - Welcome
struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Double // <- Double not Int
    let weight: Double
    
    
    static var mock: User {
        User(
            id: 444,
            firstName: "Nick",
            lastName: "Sarno",
            age: 76,
            email: "hi@hi.com",
            phone: "",
            username: "Vũ",
            password: "",
            image: Contants.randomImage,
            height: 180,
            weight: 200
        )
    }
}
