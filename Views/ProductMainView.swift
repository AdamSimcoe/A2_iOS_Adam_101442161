//
//  ProductMainView.swift
//  A2_iOS_Adam_101442161
//
//  Created by Adam Simcoe on 2025-03-27.
//

import SwiftUI

struct ProductMainView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)]
    ) var products: FetchedResults<Product>
    
    @State private var currentIndex = 0
    @State private var searchText = ""
    
    var body: some View {
        
        VStack {
            
            if !filteredProducts.isEmpty {
                let product = filteredProducts[currentIndex]
                
                Text(product.productName ?? "Product name unavailable")
                
                Text(product.productDescription ?? "Product description unavailable")
                
                Text("Price: $\(product.productPrice, specifier: "%.2f")")
                
                Text("Provider: \(product.productProvider ?? "Provider unavailable")")
                
                HStack {
                    
                    Button("Previous Product") {
                        
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }
                    .disabled(currentIndex == 0)
                    
                    Button("Next Product") {
                        
                        if currentIndex < filteredProducts.count - 1 {
                            currentIndex += 1
                        }
                    }
                    .disabled(currentIndex == filteredProducts.count - 1)
                }
            } else {
                Text("No matching products could be found.")
            }
            
            TextField("Search Product List by name or description", text: $searchText)
        }
    }
    
    var filteredProducts: [Product] {
        
        if searchText.isEmpty {
            return Array(products)
        } else {
            return products.filter {
                ($0.productName?.localizedCaseInsensitiveContains(searchText) ?? false) || ($0.productDescription?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }
}
