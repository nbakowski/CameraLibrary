//
//  CameraLibraryApp.swift
//  CameraLibrary
//
//  Created by Nikodem Bąkowski on 16/07/2025.
//

import SwiftUI
import SwiftData

@main
struct CameraLibraryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: CameraData.self)
    }
}
