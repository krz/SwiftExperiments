//
//  ContentView.swift
//  iExpense
//
//  Created by Christoph on 01.02.24.
//
import SwiftData
import SwiftUI

@Model
class Expense {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]

    @State private var showingAddExpense = false
    
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount),
    ]
    
    @State private var showType = "All"

    var body: some View {
        NavigationStack {
            ItemView(showType: showType, sortOrder: sortOrder)
//            List {
//                ForEach(expenses) { item in
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(item.name)
//                                .font(.headline)
//                            
//                            Text(item.type)
//                        }
//                        
//                        Spacer()
//                        
//                        Text(item.amount, format: .currency(code: "EUR"))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\Expense.name),
                                SortDescriptor(\Expense.amount),
                            ])
                        
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\Expense.amount),
                                SortDescriptor(\Expense.name)
                            ])
                    }
                }
                
                Menu("Filter", systemImage: "line.horizontal.3.decrease.circle") {
                    Picker("Sort", selection: $showType) {
                        Text("Show Personal")
                            .tag("Personal")
                        
                        Text("Show Business")
                            .tag("Business")
                        
                        Text("Show All")
                            .tag("All")
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView()
            }
        }
    }

    func deleteItems(at indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(expenses[index])
        }
    }

}

#Preview {
    ContentView()
}
