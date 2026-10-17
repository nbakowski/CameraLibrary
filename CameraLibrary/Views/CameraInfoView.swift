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
    let placeholderImage: UIImage
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
            
        Image(uiImage: camera.image ?? placeholderImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: CameraInfoConstants.segmentWidth, height: CameraInfoConstants.segmentHeight)
            .shadow(color: Color.black, radius: CameraInfoConstants.shadowRadius)
        
        Spacer()
        
        VStack {
            ScrollView {
                Text(camera.cameraDescription)
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
