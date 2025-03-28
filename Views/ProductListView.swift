//
//  Untitled.swift
//  A2_iOS_Adam_101442161
//
//  Created by Adam Simcoe on 2025-03-27.
//

import SwiftUI

struct ProductListView: View {
    
    // Fetch all products from Core Data, sort them based on Product Name in ascending order
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)]
    ) var products: FetchedResults<Product>
    
    var body: some View {
        
        ScrollView {
            
            VStack (spacing: 15) {
                
                // Loop to list all products using id as identifier
                ForEach(products, id: \.id) { product in
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        // Product name text display
                        Text(product.productName ?? "Product name unavailable")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        // Product description text display
                        Text(product.productDescription ?? "Product description unavailable")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.green.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.green.opacity(0.4), lineWidth: 1.5)
                            )
                    )
                    .shadow(color: Color.green.opacity(0.1), radius: 2, x: 0, y: 1)
                }
            }
            .padding(.top)
        }
        // Navigation bar title
        .navigationTitle("All Products List")
    }
}

