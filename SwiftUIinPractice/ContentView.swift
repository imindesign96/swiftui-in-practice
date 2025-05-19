//
//  ContentView.swift
//  SwiftUIinPractice
//
//  Created by Phan Ngoc Vu on 2025/05/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users: [User] = []
    @State private var products: [Product] = []

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(products) { product in
                        Text(product.title)
                    }
                }
            }
            
        }
        .padding()
        .task {
            await getData()
        }
    }
    
    private func getData() async {
        do {
            users = try await DataBaseHelper().getUsers()
            products = try await DataBaseHelper().getProducts()

        } catch {
            
        }
    }
}

#Preview {
    ContentView()
}
