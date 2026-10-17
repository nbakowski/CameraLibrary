//
//  ContentView.swift
//  CameraLibrary
//
//  Created by Nikodem Bąkowski on 16/07/2025.
//

import SwiftUI
import SwiftData

struct TileConstants {
    static let tileCornerRadius: CGFloat = 20
    static let shadowRadius: CGFloat = 7
    static let tileWidth: Double = UIScreen.screenWidth * 0.9
    static let tileHeight: Double = UIScreen.screenHeight * 0.2
    static let cameraImageSize: Double = 130
}

struct ContentView: View {
    
    @State var selectedCamera: CameraData?
    @State private var listEntryToEdit: CameraData? = nil
    @Environment(\.modelContext) private var modelContext
    @Query private var CameraList: [CameraData]
    
    var body: some View {
        NavigationStack{
                List {
                    ForEach(CameraList) { camera in
                            CameraTileView(framework: camera)
                            .onTapGesture {
                                selectedCamera = camera
                            }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            deleteCamera(CameraList[index])
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .title) {
                        Text("Catalog").font(.title.bold())
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            listEntryToEdit = CameraData(
                                name: "",
                                imageData: Data(),
                                description: "",
                                sensorSize: "",
                                megapixels: ""
                            )
                        } label: {
                            Image(systemName: "plus")
                        }
                        .modifier(PrimaryButtonStyle())
                    }
                }
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
                .listRowSeparator(.hidden)
                .sheet(item: $listEntryToEdit) { entry in
                    AddNewCamera(
                        cameraEntry: Binding(get: { entry }, set: { _ in }),
                        onChoose: { modelContext.insert(entry) }
                    )
                }
                .sheet(item: $selectedCamera) { framework in
                    CameraInfoView(camera: framework, placeholderImage: UIImage(systemName: "camera")!)
                }
                .background(Gradient(colors: [Color.secondary.opacity(0.25), Color.primary.opacity(0.25)]))
        }
    }
    
    func deleteCamera(_ camera: CameraData) {
        modelContext.delete(camera)
    }
}

// A tile view for each camera in the list
struct CameraTileView: View {
    
    private let placeholderImage: UIImage = UIImage(systemName: "camera")!
    let framework: CameraData
    
    var body: some View {
        HStack {
            Image(uiImage: framework.image ?? placeholderImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: TileConstants.cameraImageSize, height: TileConstants.cameraImageSize)
                .shadow(radius: TileConstants.shadowRadius)
            
            CameraInfoGlance(
                name: framework.name,
                sensorSize: framework.sensorSize,
                pixelCount: framework.megapixels
            )
                
        }
        .modifier(catalogTileStyle())
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
