//
//  AddProductView.swift
//  A2_iOS_Adam_101442161
//
//  Created by Adam Simcoe on 2025-03-27.
//

import SwiftUI

struct AddProductView: View {
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var productName = ""
    @State private var productDescription = ""
    @State private var productPrice = ""
    @State private var productProvider = ""
    
    var body: some View {
        
        Form {
            
            TextField("Product Name", text: $productName)
            
            TextField("Product Description", text: $productDescription)
            
            TextField("Product Price", text: $productPrice)
                .keyboardType(.decimalPad)
            
            TextField("Product Provider", text: $productProvider)
            
            Button("Save Product") {
                
                let newProduct = Product(context: context)
                
                newProduct.id = UUID()
                newProduct.productName = productName
                newProduct.productDescription = productDescription
                newProduct.productPrice = Double(productPrice) ?? 0.0
                newProduct.productProvider = productProvider
                
                try? context.save()
                dismiss()
            }
        }
        .navigationTitle("Add a Product")
    }
}

