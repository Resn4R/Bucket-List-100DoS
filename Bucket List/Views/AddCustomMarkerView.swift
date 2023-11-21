//
//  AddCustomMarkerView.swift
//  Bucket List
//
//  Created by Vito Borghi on 09/11/2023.
//

import MapKit
import SwiftUI

struct AddCustomMarkerView: View {
    
    @Environment(\.dismiss) var dismissView
    @Environment(\.modelContext) var modelContext
    
    @StateObject var viewModel = ViewModel()
    
    @State var cameraPosition: MapCameraPosition
    @State var cameraCoordinates: CLLocationCoordinate2D
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Insert name", text: $viewModel.locationName)
                    }header: {
                        Text("Pin name")
                    }
                    Section {
                        TextField("Insert description", text: $viewModel.locationDescription, axis: .vertical)
                            .textFieldStyle(.automatic)
                    }header: {
                        Text("Pin description")
                    }
                }
                Section {
                    HStack {
                        ForEach(["blue", "red", "green", "yellow", "teal"], id: \.self) { color in
                            Button {
                                viewModel.pinColour = color
                            } label: {
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 30, height: 30)
                                    .tint(Color.convertFromString(color))
                            }
                            .padding(.horizontal)
                        }
                        
                    }
                    .padding()
                } header: {
                    Text("Pin colour")
                        .foregroundStyle(Color.convertFromString(viewModel.pinColour))
                }
                ZStack {
                    Map(initialPosition: cameraPosition)
                        .disabled(true)
                        .frame(width: 350, height: 175)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                    Image(systemName: "mappin")
                        .foregroundStyle(Color.convertFromString(viewModel.pinColour))
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Done"){
                        viewModel.savePin(cameraPosition: cameraPosition, cameraCoordinates: cameraCoordinates, modelContext: modelContext)
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



//#Preview {
//    let cameraPosition: MapCameraPosition = .region(.defaultRegion)
//    return AddCustomMarkerView( cameraPosition: cameraPosition, cameraCoordinates: CLLocationCoordinate2D(latitude: 51.2, longitude: -0.12))
//}
