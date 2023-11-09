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
    private let cameraRegion
    var cameraPosition: MapCameraPosition = .region(<#T##region: MKCoordinateRegion##MKCoordinateRegion#>)
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
    }

}

#Preview {
    MapView(locations: [Location]())
}
