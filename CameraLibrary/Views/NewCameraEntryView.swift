//
//  NewCameraEntryView.swift
//  CameraLibrary
//
//  Created by Nikodem Bąkowski on 14/10/2026.
//

import SwiftUI
import UIKit
import PhotosUI
import Vision
import CoreImage.CIFilterBuiltins

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
    @State private var image: UIImage?
    
    private var processingQueue = DispatchQueue(label: "ProcessingQueue")
    @State private var isLoading: Bool = false
    
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
                    TextField("Camera Description", text: $cameraEntry.cameraDescription)
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
                            !cameraEntry.cameraDescription.isEmpty &&
                            !cameraEntry.sensorSize.isEmpty &&
                            !cameraEntry.megapixels.isEmpty
                        ) { done() } else { dismiss() }
                    }
                    .modifier(PrimaryButtonStyle())
                }
            }
        }
    }
    
    // MARK: - Background Removal and Image Processing
    // Source: https://github.com/artemnovichkov/StickerViewExample.git
    private func createCamerImage() {
        guard let imageData = cameraEntry.imageData,
              let uiImage = UIImage(data: imageData) else {
            print("Failed to create UIImage from cameraEntry.imageData")
            return
        }
        isLoading = true
        processingQueue.async {
            guard let processedImage = self.removeBackground(from: uiImage),
                  let processedData = processedImage.pngData() else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            DispatchQueue.main.async {
                self.image = processedImage
                self.cameraEntry.imageData = processedData
                self.imageState = .success(Image(uiImage: processedImage))
                self.isLoading = false
            }
        }
    }
    
    private func processImage(_ uiImage: UIImage) async -> UIImage? {
        await withCheckedContinuation { continuation in
            processingQueue.async {
                let result = self.removeBackground(from: uiImage)
                continuation.resume(returning: result)
            }
        }
    }
    
    private func removeBackground(from uiImage: UIImage) -> UIImage? {
        guard let inputImage = CIImage(image: uiImage) else {
            print("Failed to create CIImage")
            return nil
        }
        guard let maskImage = subjectMaskImage(from: inputImage) else {
            print("Failed to create mask image")
            return nil
        }
        let outputImage = apply(mask: maskImage, to: inputImage)
        return render(ciImage: outputImage)
    }
    
    private func subjectMaskImage(from inputImage: CIImage) -> CIImage? {
        let handler = VNImageRequestHandler(ciImage: inputImage)
        let request = VNGenerateForegroundInstanceMaskRequest()
        do {
            try handler.perform([request])
        } catch {
            print("Vision request failed: \(error)")
            return nil
        }
        guard let result = request.results?.first else {
            print("No observations found")
            return nil
        }
        do {
            let maskPixelBuffer = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: handler)
            return CIImage(cvPixelBuffer: maskPixelBuffer)
        } catch {
            print(error)
            return nil
        }
    }
    
    private func render(ciImage: CIImage) -> UIImage? {
        guard let cgImage = CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent) else {
            print("Failed to render CGImage")
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
     
    private func apply(mask: CIImage, to image: CIImage) -> CIImage {
        let filter = CIFilter.blendWithMask()
        filter.inputImage = image
        filter.maskImage = mask
        filter.backgroundImage = CIImage.empty()
        return filter.outputImage ?? image
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
            
            // Process the image to remove background (subject lifting)
            if let processedImage = await processImage(uiImage),
               let processedData = processedImage.pngData() {
                self.image = processedImage
                self.cameraEntry.imageData = processedData
                self.imageState = .success(Image(uiImage: processedImage))
            } else {
                // Fallback to original image if subject lifting is unavailable or fails
                let fallbackData = uiImage.jpegData(compressionQuality: 0.8) ?? rawData
                self.image = uiImage
                self.jpegData = fallbackData
                self.cameraEntry.imageData = fallbackData
                self.imageState = .success(Image(uiImage: uiImage))
            }
            
        } catch {
            imageState = .failure(error)
        }
    }
    
    func done() {
        onChoose()
        dismiss()
    }
}
