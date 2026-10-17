//
//  CameraData.swift
//  CameraLibrary
//
//  Created by Nikodem Bąkowski on 16/07/2025.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class CameraData: Identifiable, Equatable {
    static func == (lhs: borrowing CameraData, rhs: borrowing CameraData) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var name: String
    var imageData: Data?
    var cameraDescription: String
    var sensorSize: String
    var megapixels: String
    
    init(name: String, imageData: Data, description: String, sensorSize: String, megapixels: String) {
        self.name = name
        self.imageData = imageData
        self.cameraDescription = description
        self.sensorSize = sensorSize
        self.megapixels = megapixels
    }
    
    var image: UIImage? {
        imageData.flatMap {
            UIImage(data: $0)
        }
    }
}
