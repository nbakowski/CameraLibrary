//
//  NewCameraEntryView.swift
//  CameraLibrary
//
//  Created by Nikodem Bąkowski on 14/10/2026.
//

import SwiftUI
import UIKit
import PhotosUI

enum ImageState {
    case empty
    case loading(Progress)
    case success(Image)
    case failure(Error)
}

struct AddNewCamera: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var cameraEntry: CameraData
    
    @State var selectedImage: PhotosPickerItem? = nil
    @State private var imageState: ImageState = .empty
    @State private var jpegData: Data?
    @State private var displayImage: Image?
    
    // MARK: Action Function
    let onChoose: () -> Void
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section("Image") {
                    PhotosPicker(selection: $selectedImage, matching: .images) {
                        Text("Camera Image")
                    }
                    
                    switch imageState {
                    case .empty:
                        EmptyView()
                    case .loading(let progress):
                        ProgressView(progress)
                    case .success(let displayImage):
                        displayImage
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 200)
                    case .failure:
                        Text("Failed to load image")
                            .foregroundStyle(.red)
                    }
                }
                Section("Camera Info") {
                    TextField("Camera Name", text: $cameraEntry.name)
                    TextField("Camera Description", text: $cameraEntry.description)
                }
                Section("Sensor Info") {
                    TextField("Sensor Size", text: $cameraEntry.sensorSize)
                    TextField("Megapixels Count", text: $cameraEntry.megapixels)
                }
            }
            .task(id: selectedImage) {
                await loadImage(from: selectedImage)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        // Check if the whole form is filled
                        if (
                            selectedImage != nil &&
                            !cameraEntry.name.isEmpty &&
                            !cameraEntry.description.isEmpty &&
                            !cameraEntry.sensorSize.isEmpty &&
                            !cameraEntry.megapixels.isEmpty
                        ) { done() } else { dismiss() }
                    }
                    .modifier(PrimaryButtonStyle())
                }
            }
        }
    }
    
    /// Loads the photo selection, converts HEIC/PNG data to JPEG, and updates view state.
    private func loadImage(from item: PhotosPickerItem?) async {
        guard let item else {
            imageState = .empty
            return
        }
        
        imageState = .loading(Progress(totalUnitCount: 1))
        
        do {
            guard let rawData = try await item.loadTransferable(type: Data.self),
                  let uiImage = UIImage(data: rawData) else {
                imageState = .empty
                return
            }
            
            // Prepare image & JPEG conversion
            let swiftUIImage = Image(uiImage: uiImage)
            self.jpegData = uiImage.jpegData(compressionQuality: 0.8)
            self.cameraEntry.image = swiftUIImage
            self.imageState = .success(swiftUIImage)
            
        } catch {
            imageState = .failure(error)
        }
    }
    
    func done() {
        onChoose()
        dismiss()
    }
}
