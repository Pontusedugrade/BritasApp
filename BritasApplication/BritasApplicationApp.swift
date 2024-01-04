//
//  BritasApplicationApp.swift
//  BritasApplication
//
//  Created by Pontus Berggren on 2024-01-03.
//

import SwiftUI
import SwiftData

@main
struct BritasApplicationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
        }
    }
}
