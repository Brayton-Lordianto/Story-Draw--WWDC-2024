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
            overlayTheImage(image: newValue)
        }
        .onChange(of: drawing.name, { oldValue, newValue in
            print("hi there")
        })
        .popover(isPresented: $showingImagePicker) {
            ImagePicker(image: $photoImage)
        }
    }
    
    // overlay the image to the canvas
    func overlayTheImage(image: UIImage) {
        drawing.overlayImage(image: image)
//        drawing.overlayImage(image: UIImage(named: "sun") ?? UIImage())
    }
}

#Preview {
    InsertImageButton(drawing: .constant(.init(canvas: .init(), name: "Untitled")), editingImage: .constant(false))
}
