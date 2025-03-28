//
//  Untitled.swift
//  A2_iOS_Adam_101442161
//
//  Created by Adam Simcoe on 2025-03-27.
//

import SwiftUI

struct ProductListView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)]
    ) var products: FetchedResults<Product>
    
    var body: some View {
        
        List(products, id: \.id) { product in
            
            VStack(alignment: .leading) {
                
                Text(product.productName ?? "Product name unavailable")
                    .font(.headline)
                
                Text(product.productDescription ?? "Product description unavailable")
                    .font(.subheadline)
            }
        }
        
        .navigationTitle("All Products List")
    }
}

