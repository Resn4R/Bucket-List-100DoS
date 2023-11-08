//
//  ContentView.swift
//  Bucket List
//
//  Created by Vito Borghi on 06/11/2023.
//
import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    private var cameraPosition: MapCameraPosition = .camera(MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), distance: 100_000))

    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        NavigationStack{
            
            Map(initialPosition: cameraPosition) {
                
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate, anchor: .center) {
                        Image(systemName: "mappin")
                            .onTapGesture {
                                print("Tapped on \(location.name)")
                            }
                    }
                }
                
                UserAnnotation()
            }
            .mapControls {
                MapCompass()
                MapScaleView()
                MapUserLocationButton()
                MapPitchToggle()
            }
            .mapStyle(.standard(elevation: .realistic))
        }
    }

}

#Preview {
    ContentView()
}
