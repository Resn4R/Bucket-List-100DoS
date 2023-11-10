//
//  Main Menu.swift
//  Bucket List
//
//  Created by Vito Borghi on 08/11/2023.
//
import MapKit
import CoreLocation
import SwiftData
import SwiftUI

struct CustomText: View {
    @State var text: String
    var body: some View {
        Text(text)
            .font(.headline)
            .bold()
            .fontDesign(.serif)
            .padding()
    }
}

struct Main_Menu: View {
    @Query var locations: [Location]
    
    @State private var camera = MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: 51.2, longitude: -0.12), distance: 1500)
    @State private var cameraPosition: MapCameraPosition = .region(.defaultRegion)
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CustomText(text: "Add a new pin to your Bukkit")
                        .offset(y: 30)
                    
                    NavigationLink{
                        MapView(camera: camera, cameraPosition: cameraPosition)
                    } label: {
                        Map(initialPosition: cameraPosition)
                            .frame(width: 350, height: 175)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                    .padding()
                    Section {
                        CustomText(text: "Your Saved Locations")
                            .offset(y: 30)
                        
                    }
                }
            }
            .navigationTitle("Bukkit")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
}

#Preview {
    Main_Menu()
}
