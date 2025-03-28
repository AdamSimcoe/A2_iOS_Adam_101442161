//
//  Persistence.swift
//  A2_iOS_Adam_101442161
//
//  Created by Adam Simcoe on 2025-03-27.
//

import CoreData

struct PersistenceController {
    // Shared persistence instance for throughout the app
    static let shared = PersistenceController()
    
    // Core Data container for data storage
    let container: NSPersistentContainer
    
    // Initializes container and seeds data if none already exist
    init() {
        
        // Initializes container to use Core Data model
        container = NSPersistentContainer(name: "A2_iOS_Adam_101442161")
        
        // Loads local Core Data database file
        container.loadPersistentStores { description, error in
            if let error = error {
                // Fatal error check if error occurs during loading
                fatalError("Core Data has run into an error during loading: \(error)")
            }
        }
        
        // Accesses view context
        let context = container.viewContext
        
        // Fetch request to check if data already exists
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        // If no data already exists, seed sample product data
        if (try? context.count(for: request)) == 0 {
            
            // Sample product data
            let products: [(String, String, Double, String)] = [
                ("Samsung 55 inch 4K Smart TV", "UHD 4K Smart TV with HDR", 549.99, "Samsung"),
                ("Samsung 27 inch Curved Monitor", "Full HD curved LED monitor with ultra slim design", 179.99, "Samsung"),
                ("Samsung Galaxy S23", "Latest Samsung model with Snapdragon processor", 799.99,"Samsung"),
                ("Apple MacBook Air M2", "13 inch laptop with M2 chip", 1199.00, "Apple"),
                ("Apple iPhone 15", "6.1 inch display with A16 Bionic chip", 999.00, "Apple"),
                ("Apple Mac mini M2", "Desktop computer with M2 chip and macOS Ventura", 699.00, "Apple"),
                ("Sony PlayStation 5", "Next gen gaming console with ultra fast SSD", 499.00, "Sony"),
                ("Dell XPS 15", "High performance laptop with Intel i7 and OLED display", 1499.00, "Dell"),
                ("LG UltraGear Monitor", "27 inch gaming monitor with 1ms response time", 329.99, "LG"),
                ("Google Pixel 8", "Smartphone with Tensor G3 chip and Android 14", 899.00, "Google")
            ]
            
            // Loop through product data and create new product entities
            for productData in products {
                
                // Initialize new product using context
                let product = Product(context: context)
                
                // Assign product attribute values using sample product data
                product.id = UUID()
                product.productName = productData.0
                product.productDescription = productData.1
                product.productPrice = productData.2
                product.productProvider = productData.3
            }
            
            // save all sample product data to db
            try? context.save()
        }
    }
}
