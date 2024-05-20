//
//  ContentView.swift
//  PhotoRemember
//
//  Created by Christoph on 12.05.24.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ContentView: View {
    // Swift Data
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    //
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var isNamePromptActive = false
    @State private var imageName: String = ""
    @State private var imageDataList: [[String: String]] = [] // New state variable to hold the list of image data
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                PhotosPicker(selection: $avatarItem, matching: .images) {
                    Label("Select image", systemImage: "photo")
                }
                
//                if let image = avatarImage {
//                    image
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 300, height: 300)
//                }

                
                if isNamePromptActive {
                    
                    TextField("Enter image description", text: $imageName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button("Save") {
                        saveImageNameToJson(name: imageName)
                        avatarImage = nil // Clear the image after saving
                        imageName = "" // Clear the image name
                    }
                }
                
                List(imageDataList, id: \.self) { imageData in
                    NavigationLink(destination: DetailView(image: Image(imageData["name"] ?? ""), imageName: imageData["name"] ?? "")) {
                        Text(imageData["name"] ?? "Unknown")
                    }
                }
            }
            .navigationTitle("Photo Remember")
            .onChange(of: avatarItem) {
                Task {
                    if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                        isNamePromptActive = true // Activate the name prompt
                        avatarImage = loaded
                    } else {
                        print("Failed to load image")
                    }
                }
            }
        }
    }
    
    func saveImageNameToJson(name: String) {
        let imageData = ["name": name]
        imageDataList.append(imageData) // Append the new image data to the list
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: imageData, options: []) {
            // Here you can write the jsonData to a file or handle it as needed
            print(String(data: jsonData, encoding: .utf8) ?? "Failed to convert to JSON")
            isNamePromptActive = false
        }
    }
}



struct DetailView: View {
    var image: Image
    var imageName: String
    
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Text(imageName)
                .font(.title)
        }
        .navigationBarTitle(imageName)
    }
}


#Preview {
    ContentView()
}


// https://www.youtube.com/watch?v=y3LofRLPUM8
