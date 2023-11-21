//
//  ContentView-ViewModel.swift
//  Bucket List
//
//  Created by Vito Borghi on 21/11/2023.
//

import SwiftData
import MapKit
import Foundation
import SwiftUI

extension Main_Menu {
    @MainActor class ViewModel: ObservableObject {
        
        @Query var locations: [Location]

        @Published var cameraPosition: MapCameraPosition = .userLocation(fallback: .region(.defaultRegion))
        
    }
}
