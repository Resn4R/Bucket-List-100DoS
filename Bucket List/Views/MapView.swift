//
//  ContentView.swift
//  Bucket List
//
//  Created by Vito Borghi on 06/11/2023.
//

import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var viewModel = ViewModel()
    @Binding var cameraPosition: MapCameraPosition

    var body: some View {
        NavigationStack {
                ZStack {
                    Map(position: $cameraPosition) {
                        ForEach(viewModel.locations) { location in
                            
                            let locationPosition = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                            let mapRegion = MKCoordinateRegion(center: locationPosition, latitudinalMeters: 100, longitudinalMeters: 100)
                            let cameraPosition: MapCameraPosition = .region(mapRegion)

                            Annotation(location.name, coordinate: locationPosition) {
                                NavigationLink {
                                    EditCustomPinView(locationToEdit: location, cameraPosition: cameraPosition)
                                } label: {
                                    VStack {
                                        Image(systemName: "mappin")
                                        //Text(location.name)
                                    }
                                    .foregroundStyle(Color.convertFromString(location.pinColour))
                                }
                            }
                        }
                        UserAnnotation()
                    }
                    .onAppear{ cameraPosition = .userLocation(fallback: .region(.defaultRegion)) }
                    .onMapCameraChange(frequency: .continuous) { mapCameraUpdateContext in
                        viewModel.cameraCoordinates = mapCameraUpdateContext.camera.centerCoordinate
                    }
                    .mapControls {
                        MapCompass()
                        MapUserLocationButton()
                        MapPitchToggle()
                    }
                    .mapStyle(.standard(elevation: .realistic))

                    Image(systemName: "mappin")
                        .font(.title)
                        
                    VStack {
                        HStack {
                            Button{
                                viewModel.showCustomMarkerSheet.toggle()
                            } label: {
                                Image(systemName: "plus.circle") }
                                .font(.title2)
                                .frame(width: 45, height: 45)
                                .background(.thickMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding(.vertical, 5)
                                .padding(.leading, 5)
                            Spacer()
                        }
                        Spacer()
                    }
            }
        }
        .sheet(isPresented: $viewModel.showCustomMarkerSheet) {
            viewModel.addPin()
        }
    }
}



#Preview {
    @State var cameraPosition: MapCameraPosition = .userLocation(fallback: .region(.defaultRegion))

    return MapView(cameraPosition: $cameraPosition)
}
