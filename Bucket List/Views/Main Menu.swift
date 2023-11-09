//
//  Main Menu.swift
//  Bucket List
//
//  Created by Vito Borghi on 08/11/2023.
//
import MapKit
import CoreLocation
import SwiftData
import SwiftUI

struct CustomText: View {
    @State var text: String
    var body: some View {
        Text(text)
            .font(.headline)
            .bold()
            .fontDesign(.serif)
            .padding()
    }
}

struct Main_Menu: View {
    @State private var userPosition: CLLocationCoordinate2D?
    @State private var cameraPosition: MapCameraPosition?
    @State private var customLocationPins = [Location]()
    private let defaultCoordinates: CLLocationCoordinate2D = .init(latitude: 51.5, longitude: -0.12)
    private let defaultCameraPosition: MapCameraPosition = .camera(MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), distance: 15000))
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CustomText(text: "Add a new pin to your Bukkit")
                        .offset(y: 30)
                    
                    NavigationLink{
                        MapView(locations: customLocationPins)
                    } label: {
                        Map(initialPosition: cameraPosition ?? defaultCameraPosition)
                            .frame(width: 350, height: 175)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                    .padding()
                    
                    CustomText(text: "Your Saved Locations")
                        .offset(y: 30)
                    
//                    Group {
//                        if let customLocationPins = customLocationPins {
//                            List {
//                                ForEach(customLocationPins) { pin in
//                                    
//                                }
//                            }
//                        }
//                    }
                }
            }
            .navigationTitle("Bukkit")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            // Use Core Location to get the user's current location and update the region
            // You need to import CoreLocation framework and request user's location permission
            let locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
            if let userLocation = locationManager.location?.coordinate {
                userPosition = userLocation
                cameraPosition = .camera(MapCamera(
                    centerCoordinate: userPosition ?? defaultCoordinates,
                    distance: 100_000))
            }
        }
    }
    
}

#Preview {
    Main_Menu()
}
