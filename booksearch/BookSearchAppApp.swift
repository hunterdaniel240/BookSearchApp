//
//  BookSearchAppApp.swift
//  BookSearchApp
//
//  Created by Hunter Daniel on 4/7/25.
//

import SwiftUI

@main
struct BookSearchAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
