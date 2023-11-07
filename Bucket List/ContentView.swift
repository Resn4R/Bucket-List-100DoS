//
//  ContentView.swift
//  Bucket List
//
//  Created by Vito Borghi on 06/11/2023.
//

import SwiftUI

struct ContentView: View {
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
