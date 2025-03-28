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
        
        Form {
            
            // Text input for product name
            TextField("Product Name", text: $productName)
            
            // Text input for product description
            TextField("Product Description", text: $productDescription)
            
            // Text input for product price, only accepts decimal values
            TextField("Product Price", text: $productPrice)
                .keyboardType(.decimalPad)
            
            // Text input for product provider
            TextField("Product Provider", text: $productProvider)
            
            // Save product button
            Button("Save Product") {
                
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
            }
        }
        // Navigation bar title
        .navigationTitle("Add a Product")
    }
}

