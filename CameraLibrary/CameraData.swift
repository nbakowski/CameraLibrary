//
//  CameraData.swift
//  CameraLibrary
//
//  Created by Nikodem Bąkowski on 16/07/2025.
//

import Foundation
import SwiftUI

class CameraData: Identifiable, Equatable {
    static func == (lhs: borrowing CameraData, rhs: borrowing CameraData) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    init(name: String, image: Image, description: String, sensorSize: String, megapixels: String) {
        self.name = name
        self.image = image
        self.description = description
        self.sensorSize = sensorSize
        self.megapixels = megapixels
    }
    
    let id = UUID()
    var name: String
    var image: Image
    var description: String
    var sensorSize: String
    var megapixels: String
}

let ExampleList: [CameraData] = [
        CameraData(name: "Nikon D300",
             image: Image("nikon_d300-2"),
             description: "The Nikon D300 is a 12.3-megapixel semi-professional DX format digital single-lens reflex camera that Nikon Corporation announced on 23 August 2007 along with the Nikon D3 FX format camera. The D300 was discontinued by Nikon on September 11, 2009, being replaced by the modified Nikon D300S, which was released July 30, 2009. The D300S remained the premier Nikon DX camera until the D7100 was released in early 2013.",
             sensorSize: "APS-C",
             megapixels: "12.3"
            ),
        CameraData(name: "Canon 50D",
             image: Image("canon_50d"),
             description: "The Canon EOS 50D is a 15.1-megapixel digital single-lens reflex camera. It is part of the Canon EOS line of cameras, succeeding the EOS 40D and preceding the EOS 60D. Canon announced the camera on 26 August 2008. The camera was released on 6 October 2008.",
             sensorSize: "APS-C",
             megapixels: "15.1"
            ),
        CameraData(name: "Nikon D7100",
             image: Image("nikon_d7100"),
             description: "The Nikon D7100 is a 24.1-megapixel digital single-lens reflex camera model announced by Nikon in February 2013. It is a 'prosumer' model that replaces the Nikon D7000 as Nikon's flagship DX-format camera, fitting between the company's entry-level and professional DSLR models. This camera is the first ever from Nikon with no optical low-pass filter incorporated. At launch, Nikon gave the D7100 estimated selling price in the United States as US$ 949.95 for the body.",
             sensorSize: "APS-C",
             megapixels: "24.1"
            ),
        CameraData(name: "Nikon F55",
             image: Image("nikon_f55"),
             description: "The F55 (also known as the N55 in the US or the Nikon Us in Japan) is a 35mm film SLR autofocus camera introduced by Nikon in 2002. It was targeted at a new and lower price-point than the F65 (previously Nikon's cheapest autofocus SLR). The F65 continued to be sold alongside the F55. The camera is made in Thailand. It is unique among Nikon autofocus SLRs of its era in that it does not support autofocus on Nikon lenses with AF-S silent wave motor focussing, or the VR optical stabilisation features found on some lenses. It features several different operating modes, including seven program modes that are subject specific, Aperture Priority, Shutter Priority, and Manual.",
             sensorSize: "36x24mm",
             megapixels: "None"
            )
        
    ]
        
