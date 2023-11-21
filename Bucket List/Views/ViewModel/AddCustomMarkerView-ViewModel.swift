//
//  AddCustomMarkerView-ViewModel.swift
//  Bucket List
//
//  Created by Vito Borghi on 21/11/2023.
//

import MapKit
import SwiftData
import SwiftUI
import Foundation

extension AddCustomMarkerView {
    @MainActor class ViewModel: ObservableObject {
        
        @Environment(\.dismiss) var dismissView
        @Environment(\.modelContext) var modelContext
        @Query var locations: [Location]
        
        @Published var locationName: String = ""
        @Published var locationDescription: String = ""
        @Published var pinColour: String = ""
        
        func savePin(cameraPosition: MapCameraPosition, cameraCoordinates: CLLocationCoordinate2D) {
            
            let pinName = locationName.isEmpty ? "Unnamed Pin" : locationName
            
            let newLocation = Location(id: UUID(), name: pinName, locationDescription: locationDescription, pinColour: pinColour, latitude: cameraCoordinates.latitude, longitude: cameraCoordinates.longitude)
            
            print(newLocation)
            
            modelContext.insert(newLocation)
            print("newLocation added to modelContext.")
            do {
                print("saving...")
                try modelContext.save()
                print("save completed successfully.")
            }
            catch {
                print("Saving to modelContainer failed. \(error.localizedDescription)")
            }
            dismissView()
        }
    }
}

extension Color {
    static func convertFromString(_ stringColor: String) -> Color {
        let convertingTable: [String:Color] = [
            "blue":.blue,
            "red":.red,
            "green":.green,
            "yellow":.yellow,
            "teal":.teal,
        ]
        return convertingTable[stringColor.lowercased()] ?? .black
    }
}
