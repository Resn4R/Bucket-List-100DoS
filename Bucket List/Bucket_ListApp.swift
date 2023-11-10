//
//  Bucket_ListApp.swift
//  Bucket List
//
//  Created by Vito Borghi on 06/11/2023.
//

import SwiftData
import SwiftUI

@main
struct Bucket_ListApp: App {
    var body: some Scene {
        WindowGroup {
            Main_Menu()
        }
        .modelContainer(for: Location.self)
    }
}
