//
//  MapView-ViewModel.swift
//  Bucket List
//
//  Created by Vito Borghi on 21/11/2023.
//

import SwiftData
import SwiftUI
import MapKit
import Foundation

extension MapView {
   @MainActor class ViewModel: ObservableObject {
       @Published var cameraCoordinates: CLLocationCoordinate2D = .defaultPosition
       @Published var showCustomMarkerSheet = false
       
       func addPin() -> some View {
           let locationCoordinates = CLLocationCoordinate2D(latitude: cameraCoordinates.latitude, longitude: cameraCoordinates.longitude)
           let mapRegion = MKCoordinateRegion(center: locationCoordinates, latitudinalMeters: 100, longitudinalMeters: 100)
           let mapCameraPosition: MapCameraPosition = .region(mapRegion)
           
           return AddCustomMarkerView(cameraPosition: mapCameraPosition, cameraCoordinates: cameraCoordinates)
       }
    }
}


extension CLLocationCoordinate2D {
    static let defaultPosition = CLLocationCoordinate2D(latitude: 51.2, longitude: -0.12)
}

extension MKCoordinateRegion {
    static let defaultRegion = MKCoordinateRegion(center: .defaultPosition, latitudinalMeters: 300_000, longitudinalMeters: 300_000)
}
