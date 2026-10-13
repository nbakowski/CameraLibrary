//
//  NewCameraEntryView.swift
//  CameraLibrary
//
//  Created by Nikodem Bąkowski on 14/10/2026.
//

import SwiftUI

struct AddNewCamera: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var cameraEntry: CameraData
    
    // MARK: Action Function
    let onChoose: () -> Void
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section("Camera Info") {
                    TextField("Camera Name", text: $cameraEntry.name)
                    TextField("Camera Description", text: $cameraEntry.description)
                    TextField("Sensor Size", text: $cameraEntry.sensorSize)
                    TextField("Megapixels Count", text: $cameraEntry.megapixels)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { done() }
                }
            }
        }
    }
    
    func done() {
        onChoose()
        dismiss()
    }
}
