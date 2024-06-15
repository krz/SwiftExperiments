//
//  PhotoRememberApp.swift
//  PhotoRemember
//
//  Created by Christoph on 12.05.24.
//
import SwiftData
import SwiftUI

@main
struct PhotoRememberApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
