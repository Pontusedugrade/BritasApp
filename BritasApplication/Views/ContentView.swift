//
//  ContentView.swift
//  BritasApplication
//
//  Created by Pontus Berggren on 2024-01-03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Label("Projects", systemImage: "folder.fill")
                }
            ConverterView()
                .tabItem {
                    Label("Converter", systemImage: "ruler.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
