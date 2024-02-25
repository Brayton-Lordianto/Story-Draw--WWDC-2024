//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 2/24/24.
//

import SwiftUI
import PencilKit

struct CanvasMenu: View {
    @Binding var toolSelection: tool
    @Binding var color: Color
    @Binding var drawing: DrawingModel
    @State var editingImage: Bool = false 
    
    var body: some View {
        if editingImage { 
            Button("Finish and Save") { 
                self.editingImage.toggle()
            }.buttonStyle(GrowingButton())
        } else { 
        VStack(alignment: .center) {
            TextField("", text: $drawing.name)
                .font(.title)
                .frame(width: 200)
                .padding(.bottom)
            
            Text("Color")
                .fontWeight(.black)
            HStack(spacing: 0) {
                CustomColorPicker(selectedColor: $color, drawingTool: $toolSelection)
            }
            
            Text("Tools")
                .fontWeight(.black)
                .padding(.bottom)
            toolSection()
            
            InsertImageButton(drawing: $drawing, editingImage: $editingImage)
        }.asAnyView()
            .padding(30)
            .frame(width: 135)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("MenuColor"))
            }
            .onAppear { drawing.isSelected.toggle() }
            .onDisappear { drawing.isSelected.toggle() }
    }
    }
    
    func clearButton() -> some View  {
        Button(action: {
            // the first 5 is for the canvas view so don't remove that
            for i in 5..<drawing.canvas.subviews.count {
                drawing.canvas.subviews[i].removeFromSuperview()
            }
            drawing.canvas.drawing = PKDrawing()
        }) {
            VStack {
                Image(systemName: "trash")
                Text("Clear").foregroundStyle(.white)
            }
        }
        .foregroundColor(.yellow)
    }
    
    func singleTool(label: String, imageName: String, selectedName: String? = nil, associatedTool: tool) -> some View {
        var imgName: String {
            if associatedTool == .marker && toolSelection == .marker {
                return "pencil"
            }
            return toolSelection == associatedTool ? (selectedName ?? "\(imageName).fill") : imageName
        }
        return AnyView(Button(action: {
            toolSelection = associatedTool
        }) {
            VStack {
                Image(systemName: imgName)
                Text(label).foregroundStyle(.black)
            }
        }
            .padding(.bottom)
        )
    }
    
    func downloadImageButton() -> some View {
        Button(action: {
            // Create a new graphics context with a black background color
            UIGraphicsBeginImageContextWithOptions(drawing.canvas.bounds.size, false, 1.0)
            let context = UIGraphicsGetCurrentContext()!
            context.setFillColor(UIColor.black.cgColor)
            context.fill(drawing.canvas.bounds)

            // Draw the canvas image onto the context
            drawing.canvas.drawing.image(from: drawing.canvas.bounds, scale: 1).draw(in: drawing.canvas.bounds)

            // Get the resulting image from the context
            let image = UIGraphicsGetImageFromCurrentImageContext()!

            // End the context
            UIGraphicsEndImageContext()

            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }) {
            VStack {
                Image(systemName: "square.and.arrow.down.fill")
                Text("Save in Camera Roll")
                    .frame(width: 100).foregroundStyle(.black)
            }
            .padding(.vertical)
        }
    }
    
    func toolSection() -> some View {
        VStack {
            HStack {
                singleTool(label: "marker", imageName: "pencil.circle", associatedTool: .marker)
                    .frame(width: 100)
                singleTool(label: "pen", imageName: "pencil.tip.crop.circle", associatedTool: .pen)
                    .frame(width: 100)
            }
            HStack {
                singleTool(label: "whole eraser", imageName: "circle", associatedTool: .wholeEraser)
                    .frame(width: 100)
                singleTool(label: "partial eraser", imageName: "eraser", associatedTool: .partialEraser)
                    .frame(width: 100)
            }
            downloadImageButton()
            clearButton()
        }
    }
}

#Preview {
    CanvasMenu(toolSelection: .constant(.marker), color: .constant(.blue), drawing: .constant(.init(canvas: .init(), name: "Untitled")))
}
