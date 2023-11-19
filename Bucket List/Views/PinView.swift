//
//  PinView.swift
//  Bucket List
//
//  Created by Vito Borghi on 19/11/2023.
//

import SwiftUI
import MapKit

struct PinView: View {
    
    @State var pin: Location
    @State var cameraPosition: MapCameraPosition
    
    
    var body: some View {
        NavigationStack {
            Section {
                Text(pin.locationDescription)
            }
            .padding()
            
            ZStack {
                    Map(initialPosition: cameraPosition)
                        .disabled(true)
                        .onAppear{
                            let locationCoordinates = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
                            let mapRegion = MKCoordinateRegion(center: locationCoordinates, latitudinalMeters: 100, longitudinalMeters: 100)
                            cameraPosition = .region(mapRegion)
                        }
                        .frame(width: 350, height: 275)
                        .border(Color.convertFromString(pin.pinColour))
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                    
                    VStack {
                        Image(systemName: "mappin")
                        Text(pin.name)
                    }
            }
            
            .navigationTitle(pin.name)
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: EditCustomPinView(locationToEdit: pin, cameraPosition: cameraPosition)) {
                        Text("Edit")
                    }
                }
            }
        }
    }
}

//#Preview {
//    let location = Location(id: UUID(), name: "Sample", locationDescription: "ASDASDASDADS", pinColour: "blue", latitude: 51.5, longitude: -0.12)
//    PinView(pin: location, cameraLocation: MapCameraPosition.automatic)
//}
