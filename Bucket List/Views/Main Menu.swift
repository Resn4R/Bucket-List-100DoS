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

struct Main_Menu: View {
    @State private var userPosition: CLLocationCoordinate2D?
    private let defaultCoordinates: CLLocationCoordinate2D = .init(latitude: 51.5, longitude: -0.12)
    
    private var cameraPosition: MapCameraPosition = .camera(MapCamera(
        centerCoordinate: userPosition ?? CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
        distance: 100_000))
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Add a new Pin to you Bukkit")
                        .font(.headline)
                        .bold()
                        .fontDesign(.serif)
                        .padding()
                    
                    ZStack {
                        Map(initialPosition: <#T##MapCameraPosition#>)
                        {
                           
                        }
                            .frame(width: 350, height: 175)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
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
            }
        }
    }
    
}

#Preview {
    Main_Menu()
}
