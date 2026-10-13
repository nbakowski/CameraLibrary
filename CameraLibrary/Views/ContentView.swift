//
//  ContentView.swift
//  CameraLibrary
//
//  Created by Nikodem Bąkowski on 16/07/2025.
//

import SwiftUI

struct TileConstants {
    static let tileCornerRadius: CGFloat = 20
    static let shadowRadius: CGFloat = 7
    static let tileWidth: Double = UIScreen.screenWidth * 0.8
    static let tileHeight: Double = UIScreen.screenHeight * 0.2
}

struct ContentView: View {
    
    @State var selectedCamera: CameraData?
    
    var CameraList: [CameraData] = ExampleList
    
    var body: some View {
        NavigationStack{
                ScrollView{
                    ForEach(CameraList) { camera in
                            CameraTileView(framework: camera)
                            .onTapGesture {
                                selectedCamera = camera
                            }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .title) {
                        Text("Catalog").font(.title.bold())
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            // TODO: Present a sheet to add a new entry in the list
                            print("DEBUG")
                        } label: {
                            Image(systemName: "plus")
                        }
                        .modifier(PrimaryButtonStyle())
                    }
                }
                .scrollIndicators(.hidden)
                .sheet(item: $selectedCamera) { framework in
                        CameraInfoView(camera: framework)
                    }
        }
    }
}

// A tile view for each camera in the list
struct CameraTileView: View {
    
    let framework: CameraData
    
    var body: some View {
        HStack {
            Image(framework.imageName)
                .resizable()
                .frame(width: 170, height: 170)
                .shadow(radius: TileConstants.shadowRadius)
            
            CameraInfoGlance(
                name: framework.name,
                sensorSize: framework.sensorSize,
                pixelCount: framework.megapixels
            )
                
        }
        .frame(width: TileConstants.tileWidth, height: TileConstants.tileHeight)
        .padding()
        .background(Color.main)
        .cornerRadius(TileConstants.tileCornerRadius)
        .padding()
        .shadow(radius: TileConstants.shadowRadius)
    }
}

// Quick info diplay for a camera
struct CameraInfoGlance: View {
    
    let name: String
    let sensorSize: String
    let pixelCount: String
    
    var body: some View {
        
        VStack {
            Text(name)
                .modifier(NameStyle(chosenFontColor: Color.white))
            Text("Sensor size: \(sensorSize)")
                .modifier(DescriptionStyle())
            Text("Mega pixels: \(pixelCount)")
                .modifier(DescriptionStyle())
        }
    }
    
}

#Preview {
    ContentView()
}
