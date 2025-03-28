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
                    .font(.title)
                    .padding(.top)
                
                Text(product.productDescription ?? "Product description unavailable")
                    .padding(.vertical, 2)
                
                Text("Price: $\(product.productPrice, specifier: "%.2f")")
                    .padding(.vertical, 2)
                
                Text("Provider: \(product.productProvider ?? "Provider unavailable")")
                    .padding(.bottom)
                
                HStack {
                    
                    Button("Previous Product") {
                        
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }
                    .disabled(currentIndex == 0)
                    .padding(.horizontal)
                    
                    Button("Next Product") {
                        
                        if currentIndex < filteredProducts.count - 1 {
                            currentIndex += 1
                        }
                    }
                    .disabled(currentIndex == filteredProducts.count - 1)
                    .padding(.horizontal)
                }
                .padding(.bottom)
                
            } else {
                Text("No matching products could be found.")
                    .padding()
            }
            
            TextField("Search Product List by name or description", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            NavigationLink("View All Products", destination: ProductListView())
                .padding(.top)
            
            NavigationLink("Add a New Product", destination: AddProductView())
                .padding(.bottom)
        }
        .padding()
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
