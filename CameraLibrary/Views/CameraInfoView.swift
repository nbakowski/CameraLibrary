//
//  CameraInfoView.swift
//  CameraLibrary
//
//  Created by Nikodem Bąkowski on 17/07/2025.
//

import SwiftUI

struct CameraInfoView: View {
    
    let camera: Data
    
    var body: some View {
        VStack {
            
            Text(camera.name)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Spacer()
            
            Image(camera.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(color: Color.white, radius: 15)
            
            Spacer()
            
            Text(camera.description)
                .font(.body)
                .padding()
                .fontWeight(.bold)
                .background(Color.orange)
                .foregroundStyle(.black)
        }
        .background(Color.black)
    }
}

#Preview {
    CameraInfoView(camera: Data(
        name: "Nikon D300",
        imageName: "nikon_d300-2",
        description: "The Nikon D300 is a 12.3-megapixel semi-professional DX format digital single-lens reflex camera that Nikon Corporation announced on 23 August 2007 along with the Nikon D3 FX format camera. The D300 was discontinued by Nikon on September 11, 2009, being replaced by the modified Nikon D300S, which was released July 30, 2009. The D300S remained the premier Nikon DX camera until the D7100 was released in early 2013.",
        sensorSize: "APS-C",
        megapixels: 24.2
    ))
}
