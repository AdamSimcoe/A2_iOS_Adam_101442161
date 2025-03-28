//
//  AddProductView.swift
//  A2_iOS_Adam_101442161
//
//  Created by Adam Simcoe on 2025-03-27.
//

import SwiftUI

struct AddProductView: View {
    
    // Accesses core data context for creating and saving new product
    @Environment(\.managedObjectContext) var context
    
    // Dismisses view when form has been submitted
    @Environment(\.dismiss) var dismiss
    
    // State vars for form inputs
    @State private var productName = ""
    @State private var productDescription = ""
    @State private var productPrice = ""
    @State private var productProvider = ""
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                
                // Form container
                VStack(spacing: 15) {
                    
                    // Text input for product name
                    TextField("Product Name", text: $productName)
                        .padding()
                        .frame(height: 50)
                        .background(Color.orange.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.orange.opacity(0.6), lineWidth: 1.5)
                        )
                    
                    // Text input for product description
                    TextField("Product Description", text: $productDescription)
                        .padding()
                        .frame(height: 50)
                        .background(Color.orange.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.orange.opacity(0.6), lineWidth: 1.5)
                        )
                    
                    // Text input for product price, only accepts decimal values
                    TextField("Product Price", text: $productPrice)
                        .keyboardType(.decimalPad)
                        .padding()
                        .frame(height: 50)
                        .background(Color.orange.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.orange.opacity(0.6), lineWidth: 1.5)
                        )
                    // Text input for product provider
                    TextField("Product Provider", text: $productProvider)
                        .padding()
                        .frame(height: 50)
                        .background(Color.orange.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.orange.opacity(0.6), lineWidth: 1.5)
                        )
                }
                .padding()
                .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.orange.opacity(0.05))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.orange.opacity(0.3), lineWidth: 1)
                        )
                        .shadow(color: Color.orange.opacity(0.1), radius: 2, x: 0, y: 1)
                )
                
                // Save product button
                Button(action: {
                        
                    // Creates new product entity
                    let newProduct = Product(context: context)
                        
                    // Assigns form data to new product entity
                    newProduct.id = UUID()
                    newProduct.productName = productName
                    newProduct.productDescription = productDescription
                    newProduct.productPrice = Double(productPrice) ?? 0.0
                    newProduct.productProvider = productProvider
                        
                    // Saves new product
                    try? context.save()
                        
                    // Dismisses form view
                    dismiss()
                }) {
                    
                    Text("Save Product")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        // Navigation bar title
        .navigationTitle("Add a Product")
    }
}

