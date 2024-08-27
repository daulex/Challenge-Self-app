//
//  Challenge_SelfApp.swift
//  Challenge Self
//
//  Created by Kirills Galenko on 26/08/2024.
//

import SwiftUI

@main
struct Challenge_SelfApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
