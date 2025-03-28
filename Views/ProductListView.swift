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
        
        // List display of all products, using ID as the identifier
        List(products, id: \.id) { product in
            
            // Vertical stack, aligns product name/description to the left
            VStack(alignment: .leading) {
                
                // Product name text display
                Text(product.productName ?? "Product name unavailable")
                    .font(.headline)
                
                // Product description text display
                Text(product.productDescription ?? "Product description unavailable")
                    .font(.subheadline)
            }
        }
        
        // Navigation bar title
        .navigationTitle("All Products List")
    }
}

