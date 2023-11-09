//
//  ContentView.swift
//  Bucket List
//
//  Created by Vito Borghi on 06/11/2023.
//
import MapKit
import SwiftUI
struct MapView: View {
    private var cameraPosition: MapCameraPosition = .camera(MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), distance: 100_000))

    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        NavigationStack{
                ZStack {
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
                        MapUserLocationButton()
                        MapPitchToggle()
                    }
                    .mapStyle(.standard(elevation: .realistic))
                    VStack {
                        HStack {
                            Button {
                                //add location
                            } label: { Image(systemName: "plus.circle") }
                                .font(.title2)
                                .fontWeight(.semibold)
                                .frame(width: 40, height: 40)
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding([.vertical, .leading], 15)
                            Spacer()
                        }
                        Spacer()
                    }
            }
        }
    }

}

#Preview {
    MapView()
}
