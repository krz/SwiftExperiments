//
//  ContentView.swift
//  StockViewer
//
//  Created by Christoph on 13.03.24.
//

import SwiftUI

struct Response: Codable {
    enum CodingKeys: String, CodingKey {
        case timeSeries = "Time Series (Daily)"
    }
    
    var timeSeries: [String: TimeSeries]
}

struct TimeSeries: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case close = "4. close"
        case volume = "5. volume"
    }
    
    var close: String
    var volume: String
}

struct ContentView: View {
    
    @State private var results = [TimeSeries]()
    
    var body: some View {
        NavigationStack {
            List(results, id: \.self) { timeSeries in
                VStack(alignment: .leading) {
                    Text("Close: \(timeSeries.close)")
                    Text("Volume: \(timeSeries.volume)")
                }
            }
            .task {
                await loadData()
            }
            .navigationTitle("Stock Viewer")
        }
        
    }
    
    
    func loadData() async {
        guard let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=IBM&apikey=demo") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                // map is necessary because we read in a dictionary
                results = decodedResponse.timeSeries.values.map { $0 }
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
