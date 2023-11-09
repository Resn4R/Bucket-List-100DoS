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
    private var cameraPosition: MapCameraPosition = .automatic
    @State private var locations = [Location]()

    
    var body: some View {
        NavigationStack{
                ZStack {
                    Map(initialPosition: cameraPosition) {
                        
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
                                let centre = cameraPosition.camera?.centerCoordinate
                                let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: centre?.latitude, longitude: centre?.longitude)
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
    MapView()
}
