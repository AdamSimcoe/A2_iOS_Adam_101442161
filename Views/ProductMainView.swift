//
//  ProductMainView.swift
//  A2_iOS_Adam_101442161
//
//  Created by Adam Simcoe on 2025-03-27.
//

import SwiftUI

struct ProductMainView: View {
    
    // Accesses Core Data context
    @Environment(\.managedObjectContext) var context
    
    // Fetch all products from Core Data, sort them based on Product Name in ascending order
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)]
    ) var products: FetchedResults<Product>
    
    // State vars for search product functionality
    @State private var currentIndex = 0
    @State private var searchText = ""
    
    var body: some View {
        
        VStack {
            
            // Check for if any products match current search criteria
            if !filteredProducts.isEmpty {
                
                // Gets product at current index value
                let product = filteredProducts[currentIndex]
                
                // Product name text display
                Text(product.productName ?? "Product name unavailable")
                    .font(.title)
                    .padding(.top)
                
                // Product description text display
                Text(product.productDescription ?? "Product description unavailable")
                    .padding(.vertical, 2)
                
                // Product price text display
                Text("Price: $\(product.productPrice, specifier: "%.2f")")
                    .padding(.vertical, 2)
                
                // Product provider text display
                Text("Provider: \(product.productProvider ?? "Provider unavailable")")
                    .padding(.bottom)
                
                HStack {
                    
                    // Previous product button
                    Button("Previous Product") {
                        
                        // Moves to previous product if it is not at the beginning
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }
                    // Disables button if already at the beginning
                    .disabled(currentIndex == 0)
                    .padding(.horizontal)
                    
                    // Next product button
                    Button("Next Product") {
                        
                        // Moves to next product if it is not at the end
                        if currentIndex < filteredProducts.count - 1 {
                            currentIndex += 1
                        }
                    }
                    // Disables button if already at the end
                    .disabled(currentIndex == filteredProducts.count - 1)
                    .padding(.horizontal)
                }
                .padding(.bottom)
                
            } else {
                // Text display when there are no matching products in the filtered list
                Text("No matching products could be found.")
                    .padding()
            }
            
            // Input field for searching by product name or product description
            TextField("Search Product List by name or description", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Navigation Link to the ProductListView
            NavigationLink("View All Products", destination: ProductListView())
                .padding(.top)
            
            // Navigation Link to the AddProductView
            NavigationLink("Add a New Product", destination: AddProductView())
                .padding(.bottom)
        }
        .padding()
    }
    
    // Returns filtered list of products based on user input
    var filteredProducts: [Product] {
        
        // Returns all products if the search field is empty
        if searchText.isEmpty {
            return Array(products)
        } else {
            // Returns products that have a name or description containing the search input
            return products.filter {
                ($0.productName?.localizedCaseInsensitiveContains(searchText) ?? false) || ($0.productDescription?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }
}
