//
//  ContentView.swift
//  Bucket List
//
//  Created by Vito Borghi on 06/11/2023.
//
import MapKit
import SwiftUI

struct MapView: View {
    @State var userPosition: CLLocationCoordinate2D?
    var cameraPosition: MapCameraPosition = .automatic
    @State var locations: [Location]

    
    var body: some View {
        NavigationStack{
                ZStack {
                    Map(initialPosition: cameraPosition) {
                        ForEach(locations) { location in
                            let locationPosition = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                            Annotation(coordinate: locationPosition) {
                                //content
                            } label: {
                                Label(location.name, systemImage: "mapping")
                            }

                        }
                        UserAnnotation()
                    }
                    .mapControls {
                        MapCompass()
                        MapUserLocationButton()
                        MapPitchToggle()
                    }
                    .mapStyle(.standard(elevation: .realistic))
                    
                    Circle()
                        .fill(.blue)
                        .opacity(0.3)
                        .frame(width: 32)
                        
                        
                    VStack {
                        HStack {
                            Button {
                                if let centre = cameraPosition.camera?.centerCoordinate {
                                    let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: centre.latitude, longitude: centre.longitude)
                                    locations.append(newLocation)
                                }
                            } label: { Image(systemName: "plus.circle") }
                                .font(.title2)
                                .frame(width: 50, height: 50)
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding([.vertical, .leading], 10)
                            Spacer()
                        }
                        Spacer()
                    }
            }
        }
    }

}

#Preview {
    var samplePlaces = [Location(id: UUID(), name: "Sample", description: "", latitude: 51.4, longitude: -0.12)]
    MapView(locations: samplePlaces)
}
