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

    @Binding var cameraPosition: MapCameraPosition
    @State private var cameraCoordinates: CLLocationCoordinate2D = .defaultPosition
    
    @State private var showCustomMarkerSheet = false
    
    var body: some View {
        NavigationStack {
                ZStack {
                    Map(position: $cameraPosition) {
                        ForEach(locations) { location in
                            
                            let locationPosition = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                            let mapRegion = MKCoordinateRegion(center: locationPosition, latitudinalMeters: 100, longitudinalMeters: 100)
                            let cameraPosition: MapCameraPosition = .region(mapRegion)

                            Annotation(location.name, coordinate: locationPosition) {
                                NavigationLink {
                                    EditCustomPinView(locationToEdit: location, cameraPosition: cameraPosition)
                                } label: {
                                    VStack {
                                        Image(systemName: "mappin")
                                        Text(location.name)
                                    }
                                    .foregroundStyle(Color.convertFromString(location.pinColour))
                                }
                            }
                        }
                        UserAnnotation()
                    }
                    .onAppear{ cameraPosition = .userLocation(fallback: .region(.defaultRegion)) }
                    .onMapCameraChange(frequency: .continuous) { mapCameraUpdateContext in
                        print("\(mapCameraUpdateContext.camera.centerCoordinate)")
                        print("\(String(describing: cameraPosition.camera?.centerCoordinate))")
                        cameraCoordinates = mapCameraUpdateContext.camera.centerCoordinate
                    }
                    .mapControls {
                        MapCompass()
                        MapUserLocationButton()
                        MapPitchToggle()
                    }
                    .mapStyle(.standard(elevation: .realistic))

                    Image(systemName: "mappin")
                        .font(.title)
                        
                        
                    VStack {
                        HStack {
                            Button{
                                showCustomMarkerSheet.toggle()
                            } label: {
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
        .sheet(isPresented: $showCustomMarkerSheet) {
            let locationCoordinates = CLLocationCoordinate2D(latitude: cameraCoordinates.latitude, longitude: cameraCoordinates.longitude)
            let mapRegion = MKCoordinateRegion(center: locationCoordinates, latitudinalMeters: 100, longitudinalMeters: 100)
            let mapCameraPosition: MapCameraPosition = .region(mapRegion)
            
            AddCustomMarkerView(cameraPosition: mapCameraPosition, cameraCoordinates: cameraCoordinates)
        }
    }
}

extension CLLocationCoordinate2D {
    static let defaultPosition = CLLocationCoordinate2D(latitude: 51.2, longitude: -0.12)
}

extension MKCoordinateRegion {
    static let defaultRegion = MKCoordinateRegion(center: .defaultPosition, latitudinalMeters: 300_000, longitudinalMeters: 300_000)
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
