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
    
    // Alert state vars
    @State private var showAlert = false
    @State private var alertMessage = ""
    
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
                    // Perform validation checks on user inputs
                    validateandSubmitForm()
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
        
        // Alert message display for invalid form input
        .alert("Invalid Form Input", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }
    
    func validateandSubmitForm() {
        
        // Array to track any fields that fail validation checks
        var errorFields: [String] = []
        
        // If product name is empty
        if productName.trimmingCharacters(in: .whitespaces).isEmpty {
            errorFields.append("Product Name (empty field)")
        }
        
        // If product description is empty
        if productDescription.trimmingCharacters(in: .whitespaces).isEmpty {
            errorFields.append("Product Description (empty field)")
        }
        
        // If product price is empty
        if productPrice.trimmingCharacters(in: .whitespaces).isEmpty {
            errorFields.append("Product Price (empty field)")
        }
        
        // If product provider is empty
        if productProvider.trimmingCharacters(in: .whitespaces).isEmpty {
            errorFields.append("Product Provider (empty field)")
        }
        
        // Regex to only allow letters, numbers, and spaces
        let validStringRegex = "^[a-zA-Z0-9 ]+$"
        
        // string fields to validate using regex
        let stringFields = [
            ("Product Name", productName),
            ("Product Description", productDescription),
            ("Product Provider", productProvider)
        ]
        
        // Loop through each string field to validate against regex
        for (label, value) in stringFields {
            if !value.trimmingCharacters(in: .whitespaces).isEmpty {
                // If doesnt match alphanumeric, add to error list
                if !NSPredicate(format: "SELF MATCHES %@", validStringRegex).evaluate(with: value) {
                    errorFields.append("\(label) (must be alphanumeric)")
                }
            }
        }
        
        // If price has a field that is not empty
        if !productPrice.trimmingCharacters(in: .whitespaces).isEmpty {
            // If price is a number less than or equal to 0
            if let price = Double(productPrice), price <= 0 {
                errorFields.append("Product Price (must be greater than 0)")
            } else if Double(productPrice) == nil {
                // If price cannot be converted to Double
                errorFields.append("Product Price (invalid number)")
            }
        }
        
        // Check if any errors have occurred
        if !errorFields.isEmpty {
            // Display error message list
            alertMessage = errorFields.count == 1
                // For one error
                ? "The following field is invalid:\n- \(errorFields[0])"
                // For multiple errors
                : "The following fields are invalid:\n- " + errorFields.joined(separator: "\n- ")
            
            showAlert = true
            return
        }
        
        // Creates new product entity if no errors occurred
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

