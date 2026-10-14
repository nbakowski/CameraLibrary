//
//  CameraInfoView.swift
//  CameraLibrary
//
//  Created by Nikodem Bąkowski on 17/07/2025.
//

import SwiftUI

struct CameraInfoConstants {
    static let shadowRadius: CGFloat = 15
    static let buttonSize: Double = 30
    static let segmentWidth: Double = UIScreen.screenWidth
    static let segmentHeight: Double = UIScreen.screenHeight * 0.4
}

struct CameraInfoView: View {
    
    let camera: CameraData
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Text(camera.name)
                    .modifier(NameStyle(chosenFontColor: Color.primary))
                    .padding()
                
                Spacer()
                
                Button {
                        dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: CameraInfoConstants.buttonSize, height: CameraInfoConstants.buttonSize)
                        .modifier(PrimaryButtonStyle())
                        .padding()
                    }
                }
            }
            Spacer()
            
        camera.image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: CameraInfoConstants.segmentWidth, height: CameraInfoConstants.segmentHeight)
            .shadow(color: Color.black, radius: CameraInfoConstants.shadowRadius)
        
        Spacer()
        
        VStack {
            ScrollView {
                Text(camera.description)
                    .font(.body)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundStyle(.white)
            }
            .frame(width: CameraInfoConstants.segmentWidth, height: CameraInfoConstants.segmentHeight)
        }
        .background(Color.main)
    }
}

#Preview {
    CameraInfoView(camera: CameraData(
        name: "Nikon D300",
        image: Image("nikon_d300-2"),
        description: "The Nikon D300 is a 12.3-megapixel semi-professional DX format digital single-lens reflex camera that Nikon Corporation announced on 23 August 2007 along with the Nikon D3 FX format camera. The D300 was discontinued by Nikon on September 11, 2009, being replaced by the modified Nikon D300S, which was released July 30, 2009. The D300S remained the premier Nikon DX camera until the D7100 was released in early 2013.",
        sensorSize: "APS-C",
        megapixels: "24.2"
    ))
}
