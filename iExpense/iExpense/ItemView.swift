//
//  ItemView.swift
//  iExpense
//
//  Created by Christoph on 23.03.24.
//
import SwiftData
import SwiftUI

struct ItemView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    var body: some View {
        List {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        
                        Text(item.type)
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: "EUR"))
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    init(showType: String, sortOrder: [SortDescriptor<Expense>]) {
        if showType == "Personal" {
            _expenses = Query(filter: #Predicate<Expense> { expense in
                expense.type == "Personal"
            }, sort: sortOrder)
        } else if showType == "Business" {
            _expenses = Query(filter: #Predicate<Expense> { expense in
                expense.type == "Business"
            }, sort: sortOrder)
        } else if showType == "All" {
            _expenses = Query(sort: sortOrder)
        } else {
            fatalError("Invalid showType provided: \(showType)")
        }
    }

    
    func deleteItems(at indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(expenses[index])
        }
    }
}

#Preview {
    ItemView(showType: "Personal", sortOrder: [SortDescriptor(\Expense.name)])
        .modelContainer(for: Expense.self)
}
