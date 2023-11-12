//
//  Location.swift
//  Bucket List
//
//  Created by Vito Borghi on 09/11/2023.
//

import SwiftData
import MapKit
import Foundation
import SwiftUI

@Model
class Location: Identifiable, Equatable {
    let id: UUID
    var name: String
    var locationDescription: String
    let pinColour: String
    let latitude: Double
    let longitude: Double

    init(id: UUID, name: String, locationDescription: String, pinColour: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.locationDescription = locationDescription
        self.pinColour = pinColour
        self.latitude = latitude
        self.longitude = longitude
    }
}
