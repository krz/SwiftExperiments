//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Christoph on 01.02.24.
//
import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
