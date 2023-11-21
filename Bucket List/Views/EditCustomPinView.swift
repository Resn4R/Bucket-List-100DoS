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

    @ObservedObject var viewModel = ViewModel()
    
    @State var locationToEdit: Location
    @State var cameraPosition: MapCameraPosition

    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Text("Pin Name")
                        TextField("Pin name", text: $locationToEdit.name)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    VStack(alignment: .leading){
                        Text("Pin Description")
                        TextField("Pin description", text: $locationToEdit.locationDescription, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                    }
                }
            }
            Spacer()
            ZStack {
                Map(initialPosition: cameraPosition, interactionModes: .zoom)
                    .onAppear{
                        let locationCoordinates = CLLocationCoordinate2D(latitude: locationToEdit.latitude, longitude: locationToEdit.longitude)
                        let mapRegion = MKCoordinateRegion(center: locationCoordinates, latitudinalMeters: 100, longitudinalMeters: 100)
                        cameraPosition = .region(mapRegion)
                    }

                    .frame(width: 350, height: 275)
                    .border(Color.convertFromString(locationToEdit.pinColour))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                
                VStack {
                    Image(systemName: "mappin")
                    Text(locationToEdit.name)
                }
            }
            .foregroundStyle(Color.convertFromString(locationToEdit.pinColour))
        }
        .navigationTitle("Edit \(locationToEdit.name)")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    dismissView()
                    //SwiftData should update items automatically when passed to a function. Need to double check though.
                }
            }
        }
    }
}

//#Preview {
//    let locationToEdit = Location(id: UUID(), name: "Sample", locationDescription: "asASDASDASD", pinColour: "blue", latitude: 51.5, longitude: -0.12)
//    let cameraPosition: MapCameraPosition = .region(.defaultRegion)
//    
//    return EditCustomPinView(locationToEdit: locationToEdit, cameraPosition: cameraPosition)
//}
