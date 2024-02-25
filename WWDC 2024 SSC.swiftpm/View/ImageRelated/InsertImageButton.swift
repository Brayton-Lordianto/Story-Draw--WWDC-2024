//
//  SwiftUIView.swift
//
//
//  Created by Brayton Lordianto on 2/24/24.
//

import SwiftUI

struct InsertImageButton: View {
    @Binding var drawing: DrawingModel
    @Binding var editingImage: Bool
    @State var showingImagePicker: Bool = false
    @State var photoImage: UIImage? = nil
    
    var body: some View {
        Button("Insert Image from Files") {
            showingImagePicker.toggle()
        }
        .buttonStyle(GrowingButton())
        .onChange(of: photoImage, initial: false) { (_, newValue) in
            guard let newValue else { return }
            overlayImage(image: newValue)
        }
        .popover(isPresented: $showingImagePicker) {
            ImagePicker(image: $photoImage)
        }
    }
    
    // overlay the image to the canvas
    func overlayImage(image: UIImage) {
        drawing.overlayImage(image: image)
    }
}

#Preview {
    InsertImageButton(drawing: .constant(.init(canvas: .init(), name: "Untitled")), editingImage: .constant(false))
}
