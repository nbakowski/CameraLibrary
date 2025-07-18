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

struct FrameworkTitleView: View {
    
    let framework: Data
    
    var body: some View {
        HStack {
            Image(framework.imageName)
                .resizable()
                .frame(width: 170, height: 170)
                .shadow(radius: 7)
            VStack {
                Text(framework.name)
                    .modifier(NameStyle(chosenFontColor: Color.black))
                Text("Sensor size: \(framework.sensorSize)")
                    .modifier(DescriptionStyle())
                Text("Mega pixels: \(String(framework.megapixels))")
                    .modifier(DescriptionStyle())
            }
        }
        .frame(width: 325, height: 170)
        .padding()
        .background(Color.orange)
        .cornerRadius(20)
        .padding()
    }
}
