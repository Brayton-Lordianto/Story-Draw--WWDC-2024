//
//  SwiftUIView.swift
//
//
//  Created by Brayton Lordianto on 2/24/24.
//

import SwiftUI

struct InsertImageButton: View {
    @State var showingImagePicker: Bool = false
    @State var drawingAsImage: UIImage? = nil
    
    var body: some View {
        Button("hi") {
            showingImagePicker.toggle()
        }
        .onChange(of: drawingAsImage, initial: false) { (_, newValue) in
            guard let newValue else { return }
            overlayImage(image: newValue)
        }
        .popover(isPresented: $showingImagePicker) {
            ImagePicker(image: $drawingAsImage)
        }
    }
    
    // overlay the image to the canvas
    func overlayImage(image: UIImage) {
        
    }
}
