//
//  DetailView.swift
//  BritasApplication
//
//  Created by Pontus Berggren on 2024-01-03.
//

import SwiftUI
import SwiftData




struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Query var items: [Item]
    
    @State private var path = [Item]()
    var item: Item
    
    var body: some View {
        ScrollView {
            VStack {
                TabView {
                    ForEach(item.image, id: \.self) { image in
                        if let uiImage = UIImage(data: image) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 800)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                    }
                }
                .frame(height: 300)
                .aspectRatio(contentMode: .fill)
                .tabViewStyle(.page)
            }
            VStack {
                Section(header: Text("Description").font(.headline)){
                    Text(item.about)
                    
                }
                Divider()
                Section(header: Text("Creation date").font(.headline)) {
                    Text("\(item.timestamp.formatted())")
                }
            }
        }
        .navigationTitle("\(item.name)")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Item.self, configurations: config)
        let example = Item(name: "Example project", about: "Example details", timestamp: .now, category: "Example category")
        return DetailView(item: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
    
}

