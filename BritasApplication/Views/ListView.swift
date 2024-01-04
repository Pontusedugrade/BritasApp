//
//  ListView.swift
//  BritasApplication
//
//  Created by Pontus Berggren on 2024-01-03.
//

import SwiftData
import SwiftUI


struct ListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var items: [Item]
    @State private var showingDetailsView = false
    @State private var searchText = ""
    
    @State private var showCreate = false
    @State private var itemUpdate: Item?
    
    @State private var done = false
    
    
    
    var filteredItems: [Item] {
        if searchText.isEmpty {
            return items
        }
        
        let filteredItems = items.compactMap { item in
            let titleContainsQuery = item.name.range(of: searchText, options: .caseInsensitive) != nil
            
            let categoryTitleContainsQuery = item.category.range(of: searchText, options: .caseInsensitive) != nil
            
            return (titleContainsQuery || categoryTitleContainsQuery) ? item : nil
        }
        
        return filteredItems
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(filteredItems) { item in
                        NavigationLink {
                            DetailView(item: item)
                        } label: {
                            VStack {
                                Text(item.name)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(item.category)
                                    .foregroundStyle(.white)
                                Text("\(item.timestamp.formatted())")
                                    .font(.caption)
                                    .foregroundStyle(.white)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(item.isDone ? .green : .yellow)
                        }
                        .contextMenu {
                            Group {
                                
                                Button("Update project", systemImage: "pencil") {
                                    itemUpdate = item
                                }
                                
                                Button(item.isDone ? "Mark not done" : "Mark done", systemImage: "flag.checkered") {
                                    item.isDone.toggle()
                                    done = item.isDone
                                }
                            }
                            Divider()
                            Button {
                                modelContext.delete(item)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                        }
                    }
                    .clipShape(.rect(cornerRadius: 10))
                    
                    
                    
                }
                
            }
            .toolbar {
                Button("Lägg till projekt", systemImage: "plus") {
                    showCreate.toggle()
                }
            }
            
            .sheet(isPresented: $showCreate) {
                AddView()
            }
            .sheet(item: $itemUpdate) {
                itemUpdate = nil
            } content: { item in
                UpdateView(item: item)
            }
            .navigationTitle("My projects").searchable(text: $searchText, prompt: "Search for project name or category")
            
            
            
            
            WelcomeView()
        }
        
        
    }
    func removeItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = items[index]
            modelContext.delete(item)
        }
    }
    
    
    
}


#Preview {
    ListView()
        .modelContainer(for: Item.self)
}

