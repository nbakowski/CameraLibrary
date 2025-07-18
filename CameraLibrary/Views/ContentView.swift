//
//  ContentView.swift
//  CameraLibrary
//
//  Created by Nikodem Bąkowski on 16/07/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedFramework: Data! = nil
    
    var body: some View {
        NavigationView{
                ScrollView{
                    ForEach(DataCollection.cameraData) { framework in
                            FrameworkTitleView(framework: framework)
                            .onTapGesture {
                                selectedFramework = framework
                            }
                    }
                    .sheet(item: $selectedFramework) { framework in
                            CameraInfoView(camera: framework)
                        }
                }
                .navigationTitle("Catalog")
        }
        .scrollIndicators(.hidden)
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
                    .font(.title)
                    .fontWeight(.bold)
                    .scaledToFit()
                    .minimumScaleFactor(0.5)
                    .foregroundColor(Color.black)
                Text("Sensor size: \(framework.sensorSize)")
                    .font(.footnote)
                    .scaledToFit()
                    .foregroundColor(Color.black)
                Text("Mega pixels: \(String(framework.megapixels))")
                    .font(.footnote)
                    .scaledToFit()
                    .foregroundColor(Color.black)
            }
        }
        .frame(width: 325, height: 170)
        .padding()
        .background(Color.orange)
        .cornerRadius(20)
        .padding()
    }
}
