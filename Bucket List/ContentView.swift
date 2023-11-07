//
//  ContentView.swift
//  Bucket List
//
//  Created by Vito Borghi on 06/11/2023.
//

import SwiftUI

struct User: Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
}

struct ContentView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ]
    
    let values = [1,4,6,7,2,8,9].sorted()
    
    var body: some View {
        List(values, id: \.self) {
            Text(String($0))
        }
    }
}

#Preview {
    ContentView()
}
