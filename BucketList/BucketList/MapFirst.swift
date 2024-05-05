////
////  ContentView.swift
////  BucketList
////
////  Created by Christoph on 20.04.24.
////
//import MapKit
//import SwiftUI
//
//struct LocationOld: Identifiable {
//    let id = UUID()
//    var name: String
//    var coordinate: CLLocationCoordinate2D
//}
//
//
//struct MapFirst: View {
//    
//    let locations = [
//        LocationOld(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
//        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
//    ]
//    
//    @State private var position = MapCameraPosition.region(
//        MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
//    )
//    
//    var body: some View {
//        VStack {
////            Map(position: $position)
////                .mapStyle(.hybrid(elevation: .realistic))
////                .onMapCameraChange {
////                    context in print(context.region)
////                }
//            Map {
//                ForEach(locationsOLD) { location in
//                    Annotation(location.name, coordinate: location.coordinate) {
//                        Text(location.name)
//                            .font(.headline)
//                            .padding()
//                            .background(.blue)
//                            .foregroundStyle(.white)
//                            .clipShape(.capsule)
//                    }
//                    .annotationTitles(.hidden)
//                }
//            }
//            
//            HStack(spacing: 50) {
//                Button("Paris") {
//                    position = MapCameraPosition.region(
//                        MKCoordinateRegion(
//                            center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
//                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//                        )
//                    )
//                }
//
//                Button("Tokyo") {
//                    position = MapCameraPosition.region(
//                        MKCoordinateRegion(
//                            center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
//                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//                        )
//                    )
//                }
//            }
//        }
//    }
//    
//}
//
//#Preview {
//    MapFirst()
//}
