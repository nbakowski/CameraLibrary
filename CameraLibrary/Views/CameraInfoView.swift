//
//  CameraInfoView.swift
//  CameraLibrary
//
//  Created by Nikodem Bąkowski on 17/07/2025.
//

import SwiftUI

struct CameraInfoView: View {
    
    let camera: CameraData
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            
            HStack {
                Text(camera.name)
                    .modifier(NameStyle(chosenFontColor: Color.black))
                    .padding()
                
                Spacer()
                
                Button {
                        dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .modifier(PrimaryButtonStyle())
                        .padding()
                    }
                
                }
            }
            Spacer()
            
            Image(camera.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(color: Color.black, radius: 15)
            
            Spacer()
            
            VStack {
                ScrollView {
                    Text(camera.description)
                        .font(.body)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundStyle(.white)
                }
            }
            .background(Color.main)
        }
}

#Preview {
    CameraInfoView(camera: CameraData(
        name: "Nikon D300",
        imageName: "nikon_d300-2",
        description: "The Nikon D300 is a 12.3-megapixel semi-professional DX format digital single-lens reflex camera that Nikon Corporation announced on 23 August 2007 along with the Nikon D3 FX format camera. The D300 was discontinued by Nikon on September 11, 2009, being replaced by the modified Nikon D300S, which was released July 30, 2009. The D300S remained the premier Nikon DX camera until the D7100 was released in early 2013.",
        sensorSize: "APS-C",
        megapixels: "24.2"
    ))
}
