//
//  ContentView.swift
//  BucketList
//
//  Created by Christoph on 20.04.24.
//
import MapKit
import SwiftUI


struct ContentView: View {
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51, longitude: 10),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var viewModel = ViewModel()
    
    // Challenge 1
    @State private var myMapStyle = false
    
    var body: some View {
        if viewModel.isUnlocked {
            MapReader { proxy in
                ZStack {
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(myMapStyle ? .hybrid : .standard)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                    // Challenge 1 (ZStack added for transparency)
                    Button(action: {
                        myMapStyle.toggle()
                    }) {
                        Image(systemName: "map")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .background(Color.clear)
                    
                }
                // Challenge 2, not sure if working
                .alert(isPresented: $viewModel.unlockFailed) {
                            Alert(title: Text("Authentication Error"), message: Text("Unlock Error"), dismissButton: .default(Text("OK")))
                        }
            }
        } else {
            Button("Unlock places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
}

#Preview {
    ContentView()
}
