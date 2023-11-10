//
//  ContentView.swift
//  Bucket List
//
//  Created by Vito Borghi on 06/11/2023.
//

import SwiftData
import MapKit
import SwiftUI

struct MapView: View {
    @Query var locations: [Location]

    @State var camera: MapCamera
    @State var cameraPosition: MapCameraPosition
    
    @State private var showCustomMarkerSheet = false
    
    var body: some View {
        NavigationStack{
                ZStack {
                    Map(position: $cameraPosition ) {
                        ForEach(locations) { location in
                            let locationPosition = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                            Annotation(coordinate: locationPosition) {
                                //content
                            } label: {
                                Label(location.name, systemImage: "mappin")
                            }

                        }
                        UserAnnotation()
                    }
                    .mapControls {
                        MapCompass()
                        MapUserLocationButton()
                        MapPitchToggle()
                    }
                    .mapStyle(.standard(elevation: .realistic))

                    Circle()
                        .fill(.blue)
                        .opacity(0.3)
                        .frame(width: 32)
                        
                        
                    VStack {
                        HStack {
                            Button{
                                showCustomMarkerSheet.toggle()
                            } label: {
                                // label
                                Image(systemName: "plus.circle") }
                                .font(.title2)
                                .frame(width: 45, height: 45)
                                .background(.thickMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding(.vertical, 5)
                                .padding(.leading, 5)
                            Spacer()
                        }
                        Spacer()
                    }
            }
        }
        .sheet(isPresented: $showCustomMarkerSheet, content: {
            AddCustomMarkerView()
        })
    }
}

extension CLLocationCoordinate2D {
    static let defaultPosition = CLLocationCoordinate2D(latitude: 51.2, longitude: -0.12)
}

extension MKCoordinateRegion {
    static let defaultRegion = MKCoordinateRegion(center: .defaultPosition, latitudinalMeters: 10000, longitudinalMeters: 10000)
}

//
//#Preview {
//    var customLocationPins = [Location]()
//    
//    var camera = MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: 51.2, longitude: -0.12), distance: 1500)
//    var cameraPosition: MapCameraPosition = .region(.defaultRegion)
//    
//    MapView(camera: camera, cameraPosition: cameraPosition)
//}
