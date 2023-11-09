//
//  Location.swift
//  Bucket List
//
//  Created by Vito Borghi on 09/11/2023.
//
import MapKit
import Foundation

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
