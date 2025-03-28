//
//  A2_iOS_Adam_101442161App.swift
//  A2_iOS_Adam_101442161
//
//  Created by Adam Simcoe on 2025-03-27.
//

import SwiftUI

@main
struct A2_iOS_Adam_101442161App: App {
    
    // shared persistence instance to access Core Data
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            // Navigation View for NavigationLink functionality
            NavigationView {
                ProductMainView()
            }
            
            // Core Data Context injection to be used by other views
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
