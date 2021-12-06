//
//  TouristApplicationApp.swift
//  TouristApplication
//
//  Created by iosdev on 18.11.2021.
//

import SwiftUI

@main
struct TouristApplicationApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
            Speech()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
