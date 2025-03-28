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
        
        ScrollView {
            
            VStack(spacing: 20) {
                
                // Check for if any products match current search criteria
                if !filteredProducts.isEmpty {
                    
                    // Gets product at current index value
                    let product = filteredProducts[currentIndex]
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
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
                    }
                    .padding()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.blue.opacity(0.6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.blue.opacity(1.0), lineWidth: 2)
                            )
                    )
                    .padding(.horizontal)
                    
                    // Navigation Buttons
                    HStack(spacing: 30) {
                        
                        // Previous product button
                        Button(action: {
                            
                            // Moves to previous product if it is not at the beginning
                            if currentIndex > 0 {
                                currentIndex -= 1
                            }
                        }) {
                            Text("Previous Product")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.blue.opacity(currentIndex == 0 ? 0.2 : 1.0))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        // Disables button if already at the beginning
                        .disabled(currentIndex == 0)
                        
                        // Next product button
                        Button(action: {
                            
                            // Moves to next product if it is not at the end
                            if currentIndex < filteredProducts.count - 1 {
                                currentIndex += 1
                            }
                        }) {
                            Text("Next Product")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.blue.opacity(currentIndex == filteredProducts.count - 1 ? 0.2 : 1.0))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        // Disables button if already at the end
                        .disabled(currentIndex == filteredProducts.count - 1)
                    }
                    .padding(.top, 10)
                    
                } else {
                    // Text display when there are no matching products in the filtered list
                    Text("No matching products could be found.")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                // Input field for searching by product name or product description
                TextField("Search Product List by name or description", text: $searchText)
                    .padding()
                    .frame(height: 50)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.6), lineWidth: 2)
                    )
                    .padding(.horizontal)
                
                VStack(spacing: 10) {
                    
                    // Navigation Link to the ProductListView
                    NavigationLink(destination: ProductListView()) {
                        
                        Text("View All Products")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    // Navigation Link to the AddProductView
                    NavigationLink(destination: AddProductView()) {
                        
                        Text("Add a Product")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        // Navigation bar title
        .navigationTitle("Product Display")
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
