//
//  ContentView.swift
//  FriendFace
//
//  Created by Christoph on 29.03.24.
//

import SwiftUI

struct User: Codable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var friends: [Friend]
}

struct Friend: Codable {
    var id: String
    var name: String
}

struct ContentView: View {
    
    @State private var results = [User]()
    
    var body: some View {
        NavigationStack {
            List(results, id: \.id) { item in
                NavigationLink(destination: UserView(user: item)) {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.company)
                        Text("Age: \(item.age)")
                        Text("Registered on \(formatDate(item.registered))")
                            .font(.caption)
                    }
                }
            }
            .task {
                await loadData()
            }
            .navigationTitle("FriendFace")
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            // Array here
            if let decodedResponse = try?
                decoder.decode([User].self, from: data) {
                results = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

#Preview {
    ContentView()
}
