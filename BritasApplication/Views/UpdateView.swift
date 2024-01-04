//
//  UpdateView.swift
//  BritasApplication
//
//  Created by Pontus Berggren on 2024-01-03.
//

import SwiftUI
import SwiftData

struct UpdateView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Bindable var item: Item
    
    @State private var categories = [String(localized:"Textile"), String(localized:"Clay"), String(localized:"Jewlery"), String(localized:"Other"), String(localized:"Paint")]
    @State private var category = String(localized:"Textile")
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Pick a category", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                Toggle("Is the project finished?", isOn: $item.isDone)
                
                TextField("Project name", text: $item.name)
                
                TextEditor(text: $item.about)
            }
            .toolbar {
                Button("Save changes", systemImage: "square.and.arrow.down") {
                    dismiss()
                }
            }
            .navigationTitle("Update project")
        }
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Item.self, configurations: config)
        let example = Item(name: "Example project", about: "Example details", timestamp: .now, category: "Example category")
        return UpdateView(item: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
    
}

