//
//  A2_iOS_Adam_101442161App.swift
//  A2_iOS_Adam_101442161
//
//  Created by Adam Simcoe on 2025-03-27.
//

import SwiftUI

@main
struct A2_iOS_Adam_101442161App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
           ProductMainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
