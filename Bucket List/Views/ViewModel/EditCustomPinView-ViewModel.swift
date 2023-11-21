//
//  EditCustomPinView-ViewModel.swift
//  Bucket List
//
//  Created by Vito Borghi on 21/11/2023.
//

import MapKit
import SwiftData
import SwiftUI
import Foundation

extension EditCustomPinView {
    @MainActor class ViewModel: ObservableObject {
        @Environment(\.modelContext) var modelContext
        @Environment(\.dismiss) var dismissView
    }
}
