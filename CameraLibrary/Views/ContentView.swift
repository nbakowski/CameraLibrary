//
//  ContentView.swift
//  CameraLibrary
//
//  Created by Nikodem Bąkowski on 16/07/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedFramework: Data?
    
    var body: some View {
        NavigationStack{
                ScrollView{
                    ForEach(DataCollection.cameraData) { framework in
                            FrameworkTitleView(framework: framework)
                            .onTapGesture {
                                selectedFramework = framework
                            }
                    }
                }
                .navigationTitle("Catalog")
                .scrollIndicators(.hidden)
                .sheet(item: $selectedFramework) { framework in
                        CameraInfoView(camera: framework)
                    }
        }
    }
}

#Preview {
    ContentView()
}

// A tile view for each camera in the list
struct FrameworkTitleView: View {
    
    let framework: Data
    
    var body: some View {
        HStack {
            Image(framework.imageName)
                .resizable()
                .frame(width: 170, height: 170)
                .shadow(radius: 7)
                
            CameraInfoGlance(name: framework.name, sensorSize: framework.sensorSize, pixelCount: framework.megapixels)
                
        }
        .frame(width: 325, height: 170)
        .padding()
        .background(Color.main)
        .cornerRadius(20)
        .padding()
    }
}

// Quick info diplay for a camera
struct CameraInfoGlance: View {
    
    let name: String
    let sensorSize: String
    let pixelCount: Double
    
    var body: some View {
        
        VStack {
            Text(name)
                .modifier(NameStyle(chosenFontColor: Color.white))
            Text("Sensor size: \(sensorSize)")
                .modifier(DescriptionStyle())
            Text("Mega pixels: \(String(pixelCount))")
                .modifier(DescriptionStyle())
        }
    }
    
}
