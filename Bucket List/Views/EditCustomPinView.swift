//
//  EditCustomPinView.swift
//  Bucket List
//
//  Created by Vito Borghi on 11/11/2023.
//

import SwiftData
import SwiftUI
import MapKit

struct EditCustomPinView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismissView
    
    @State var locationToEdit: Location
    @State var cameraPosition: MapCameraPosition 
    
    var body: some View {
        Section {
            Text(locationToEdit.name)
            Text(locationToEdit.locationDescription)
            Text("location coordinates: \(locationToEdit.latitude), \(locationToEdit.longitude)")
                .padding()
            Map(initialPosition: cameraPosition)
                .onAppear{
                    let locationCoordinates = CLLocationCoordinate2D(latitude: locationToEdit.latitude, longitude: locationToEdit.longitude)
                    let mapRegion = MKCoordinateRegion(center: locationCoordinates, latitudinalMeters: 100, longitudinalMeters: 100)
                    cameraPosition = .region(mapRegion)
                    
                }
        }
        .foregroundStyle(Color.convertFromString(locationToEdit.pinColour ?? ""))
    }
}

//#Preview {
//    @State var locationToEdit = Location(id: UUID(), name: "Sample", locationDescription: "asASDASDASD", pinColour: "blue", latitude: 51.5, longitude: -0.12)
//    @State var cameraPosition: MapCameraPosition = 
//    let locationCoordinates = CLLocationCoordinate2D(latitude: locationToEdit.latitude, longitude: locationToEdit.longitude)
//    let mapRegion = MKCoordinateRegion(center: locationCoordinates, latitudinalMeters: 100, longitudinalMeters: 100)
//    cameraPosition = .region(mapRegion)
//    
//    EditCustomPinView(locationToEdit: locationToEdit, cameraPosition: cameraPosition)
//}
