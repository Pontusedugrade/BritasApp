//
//  AddView.swift
//  BritasApplication
//
//  Created by Pontus Berggren on 2024-01-03.
//
import SwiftUI
import PhotosUI
import SwiftData

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var projectName = ""
    @State private var projectDescription = "Add description"
    @State private var showingImagePicker = false
    @State private var categories = [String(localized:"Textile"), String(localized:"Clay"), String(localized:"Jewlery"), String(localized:"Other"), String(localized:"Paint")]
    @State private var category = String(localized:"Textile")
    @State private var isDone = false
    
    @State var selectedPhoto: [PhotosPickerItem] = []
    @State var selectedPhotoData: [Data] = []
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Pick a category", selection: $category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Toggle("Is the project finished?", isOn: $isDone)
                    
                    TextField("Project name", text: $projectName)
                    
                    TextEditor(text: $projectDescription)
                    
                }
                
                Section {
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(selectedPhotoData, id: \.self) { data in
                                if let uiImage = UIImage(data: data) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity, maxHeight: 100)
                                }
                            }
                        }
                    }
                    
                    PhotosPicker(selection: $selectedPhoto, maxSelectionCount: 5,
                                 matching: .images,
                                 photoLibrary: .shared()) {
                        Label("Add image", systemImage: "photo")
                    }
                    
                    if !selectedPhotoData.isEmpty {
                        
                        Button(role: .destructive) {
                            withAnimation {
                                selectedPhoto = []
                                selectedPhotoData = []
                            }
                        } label: {
                            Label("Remove image", systemImage: "xmark")
                                .foregroundStyle(.red)
                        }
                    }
                }
                    
            }
            .onChange(of: selectedPhoto, initial: true) { initial, selectedPhoto in
                selectedPhotoData = []
                for item in selectedPhoto {
                    item.loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let imageData):
                            if let imageData {
                                self.selectedPhotoData.append(imageData)
                            } else {
                                print("No supported content type found")
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
            .toolbar {
                Button("Save project", systemImage: "square.and.arrow.down") {
                    let item = Item(name: projectName, about: projectDescription, timestamp: .now, category: category, isDone: isDone, image: selectedPhotoData)
                    modelContext.insert(item)
                    
                    projectName = ""
                    projectDescription = "Add description"
                    
                    dismiss()
                    
                }
                
            }
            .navigationTitle("New project")
            .sheet(isPresented: $showingImagePicker) {
                
            }
        }
    }
}

#Preview {
    AddView()
        .modelContainer(for: Item.self)
}
