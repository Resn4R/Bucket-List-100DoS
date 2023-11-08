//
//  ContentView.swift
//  Bucket List
//
//  Created by Vito Borghi on 06/11/2023.
//
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

    var body: some View {
        Map(coordinateRegion: $mapRegion)
            
    }
}

#Preview {
    ContentView()
}
