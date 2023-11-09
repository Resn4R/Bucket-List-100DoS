//
//  Location.swift
//  Bucket List
//
//  Created by Vito Borghi on 09/11/2023.
//
import MapKit
import Foundation

struct Location: Identifiable, Codable, Equatable {    
    let id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
}
