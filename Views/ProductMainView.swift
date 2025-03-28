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
