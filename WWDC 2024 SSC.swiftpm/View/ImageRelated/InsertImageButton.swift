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
        let imageView = DraggableImageView(image: image)
        imageView.isUserInteractionEnabled = true
        imageView.isMultipleTouchEnabled = true 
//        imageView.frame = .init(origin: .zero, size: .init(width: 100, height: 100))
//        imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        drawing.canvas.addSubview(imageView)
//        drawing.overlaidImages.append(image)
    }
}

#Preview {
    InsertImageButton(drawing: .constant(.init(canvas: .init(), name: "Untitled")), editingImage: .constant(false))
}
