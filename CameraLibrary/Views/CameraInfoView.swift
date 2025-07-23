//
//  CameraInfoView.swift
//  CameraLibrary
//
//  Created by Nikodem Bąkowski on 17/07/2025.
//

import SwiftUI

struct CameraInfoView: View {
    
    let camera: Data
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            
            HStack {
                Text(camera.name)
                    .modifier(NameStyle(chosenFontColor: Color.white))
                    .foregroundStyle(.white)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "x.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.white)
                        .padding()
                }
            }
            Spacer()
            
            Image(camera.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(color: Color.white, radius: 15)
            
            Spacer()
            
            VStack {
                Text(camera.description)
                    .font(.body)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundStyle(.black)
                Link("Source: \(camera.source)", destination: URL(string: camera.source)!)
                    .foregroundStyle(.blue)
                    .fontWeight(.bold)
                    .font(.caption)
            }
            .background(Color.orange)
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
        megapixels: 24.2,
        source: "https://en.wikipedia.org/wiki/Nikon_D300"
    ))
}
