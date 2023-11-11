//
//  AddCustomMarkerView.swift
//  Bucket List
//
//  Created by Vito Borghi on 09/11/2023.
//

import MapKit
import SwiftData
import SwiftUI

struct AddCustomMarkerView: View {
    @Environment(\.dismiss) var dismissView
    @Environment(\.modelContext) var modelContext
    @Query var locations: [Location]
    
    @State private var locationName: String = ""
    @State private var locationDescription: String = ""
    
    @Binding var cameraPosition: MapCameraPosition
    @Binding var cameraCoordinates: CLLocationCoordinate2D
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Insert name", text: $locationName)
                }header: {
                    Text("Pin name")
                }
                
                Section {
                    TextField("Insert description", text: $locationDescription, axis: .vertical)
                        .textFieldStyle(.automatic)
                }header: {
                    Text("Pin description")
                }
                
                Section {
                    HStack {
                        Button {
                            //set marker to colour
                        } label: {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 30, height: 30)
                                .tint(.blue)
                        }
                        .padding(.horizontal)
                        
                        Button {
                            //set marker to colour
                        } label: {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 30, height: 30)
                                .tint(.red)
                        }
                        .padding(.horizontal)
                        
                        Button {
                            //set marker to colour
                        } label: {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 30, height: 30)
                                .tint(.green)
                        }
                        .padding(.horizontal)
                        
                        Button {
                            //set marker to colour
                        } label: {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 30, height: 30)
                                .tint(.yellow)
                        }
                        .padding(.horizontal)
                        
                        Button {
                            //set marker to colour
                        } label: {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 30, height: 30)
                                .tint(.teal)
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                } header: {
                    Text("Pin colour")
                }
                Section{
                    Map(position: $cameraPosition )
                        .disabled(true)
                }
                .frame(width: 350, height: 175)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Done"){
                        let newLocation = Location(id: UUID(), name: locationName, locationDescription: locationDescription, latitude: cameraCoordinates.latitude, longitude: cameraCoordinates.longitude)
                        
                        modelContext.insert(newLocation)
                        
                        do { try modelContext.save() }
                        catch {
                            print("Saving to modelContainer failed.")
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismissView()
                    }
                }
            }
        }
    }
}

//#Preview {
//    let cameraPosition: MapCameraPosition = .region(.defaultRegion)
//    AddCustomMarkerView( cameraCentralPosition: cameraPosition)
//}
