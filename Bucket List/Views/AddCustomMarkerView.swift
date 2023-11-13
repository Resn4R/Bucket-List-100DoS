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
    @State private var pinColour: String?
    
    @State var cameraPosition: MapCameraPosition
    @State var cameraCoordinates: CLLocationCoordinate2D
    
    var body: some View {
        NavigationStack {
            VStack {
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
                }
                Section {
                    HStack {
                        Button {
                            pinColour = "blue"
                        } label: {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 30, height: 30)
                                .tint(.blue)
                        }
                        .padding(.horizontal)
                        
                        Button {
                            pinColour = "red"
                        } label: {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 30, height: 30)
                                .tint(.red)
                        }
                        .padding(.horizontal)
                        
                        Button {
                            pinColour = "green"
                        } label: {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 30, height: 30)
                                .tint(.green)
                        }
                        .padding(.horizontal)
                        
                        Button {
                            pinColour = "yellow"
                        } label: {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 30, height: 30)
                                .tint(.yellow)
                        }
                        .padding(.horizontal)
                        
                        Button {
                            pinColour = "teal"
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
                    Map(initialPosition: cameraPosition) //camera coordinates changes on map movement but cameraPosition doesn't; pls fix cameraPosition at cameraCoordinates
                        .disabled(true)
                        .frame(width: 350, height: 175)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .onAppear{
                            cameraPosition = .region(MKCoordinateRegion(center: cameraCoordinates, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
                        }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Done"){
                        let newLocation = Location(id: UUID(), name: locationName, locationDescription: locationDescription, pinColour: pinColour, latitude: cameraCoordinates.latitude, longitude: cameraCoordinates.longitude)
                        
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
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismissView()
                    }
                }
            }
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

//#Preview {
//    let cameraPosition: MapCameraPosition = .region(.defaultRegion)
//    AddCustomMarkerView( cameraCentralPosition: cameraPosition)
//}
