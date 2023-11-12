//
//  EditCustomPinView.swift
//  Bucket List
//
//  Created by Vito Borghi on 11/11/2023.
//

import SwiftData
import SwiftUI

struct EditCustomPinView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismissView
    
    @State var locationToEdit: Location
    
    var body: some View {
        Section {
            Text(locationToEdit.name)
            Text(locationToEdit.locationDescription)
            Text("location coordinates: \(locationToEdit.latitude), \(locationToEdit.longitude)")
        }
        .foregroundStyle(Color.convertFromString(locationToEdit.pinColour))
    }
}

#Preview {
    EditCustomPinView(locationToEdit: Location(id: UUID(), name: "Sample", locationDescription: "SMASMASMAMSMASMASMASMASMASAMSMASAMS", pinColour: "blue", latitude: 55.1, longitude: 0.23))
}
