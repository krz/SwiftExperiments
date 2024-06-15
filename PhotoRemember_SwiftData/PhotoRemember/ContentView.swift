//
//  ContentView.swift
//  PhotoRemember
//
//  Created by Christoph on 12.05.24.
//
import SwiftUI
import PhotosUI
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var imageData: Data?
    
    @State private var imageDescription: String = ""

    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    HStack {
                        if let imageData = item.image, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        Text(item.descript)
                    }
                }
                .navigationTitle("Photo Selector")

                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } else {
                    Text("No Image Selected")
                        .frame(height: 200)
                }

                PhotosPicker(
                    selection: $selectedPhoto,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Text("Select a Photo")
                }
                .onChange(of: selectedPhoto) {
                    Task {
                        await loadImageData(from: selectedPhoto)
                    }
                }

                if imageData != nil {
                    TextField("Enter image description", text: $imageDescription)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .padding()
                    
                    Button("Save Image") {
                        if let imageData = imageData {
                            saveImage(imageDescription, imageData)
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
    }

    private func loadImageData(from item: PhotosPickerItem?) async {
        if let data = try? await item?.loadTransferable(type: Data.self) {
            self.imageData = data
        }
    }

    private func saveImage(_ descript: String, _ data: Data) {
        let newItem = Item(descript: descript, image: data)
        modelContext.insert(newItem)
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
        // Reset selected photo and imageData after saving
        selectedPhoto = nil
        imageData = nil
        imageDescription = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.environment(\.modelContext, ModelContext(inMemory: true))
    }
}
