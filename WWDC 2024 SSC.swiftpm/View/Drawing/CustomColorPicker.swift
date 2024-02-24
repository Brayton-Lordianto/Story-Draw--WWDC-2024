//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 2/24/24.
//

import SwiftUI
import PencilKit

struct CustomColorPickerSample: View {
    @State private var selectedColor = Color.blue
    @State var isDraw: tool = .marker
    var body: some View {
        ZStack {
            CustomColorPicker(selectedColor: $selectedColor, drawingTool: $isDraw)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CanvasMenu: View {
    @Binding var toolSelection: tool
    @Binding var color: Color
    @Binding var canvas: PKCanvasView
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Color")
                .fontWeight(.black)
            HStack(spacing: 0) {
                CustomColorPicker(selectedColor: $color, drawingTool: $toolSelection)
            }
            
            Text("Tools")
                .fontWeight(.black)
                .padding(.bottom)
            toolSection()
        }
        .padding(30)
        .frame(width: 135)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("MenuColor"))
        }
    }
    
    func clearSelection() -> some View  {
        Button(action: {
            canvas.drawing = PKDrawing()
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
            UIGraphicsBeginImageContextWithOptions(canvas.bounds.size, false, 1.0)
            let context = UIGraphicsGetCurrentContext()!
            context.setFillColor(UIColor.black.cgColor)
            context.fill(canvas.bounds)

            // Draw the canvas image onto the context
            canvas.drawing.image(from: canvas.bounds, scale: 1).draw(in: canvas.bounds)

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
            clearSelection()
        }
    }
}

struct CustomColorPicker: View {
    @Binding var selectedColor: Color
    @Binding var drawingTool: tool
    let colors: [Color] = [.white,
                           .purple,
                           .red,
                           .orange]
    let colors2: [Color] = [.yellow,
                            .green,
                            .pink,
                            .cyan]
    let colors3: [Color] = [.mint,
                            .indigo,
                            .teal,
                            .blue]
    var body: some View {
        HStack(spacing: 10) {
            VStack(spacing: 20) {
                ForEach(colors, id: \.self) { color in
                    button(color: color)
                }
            }
            VStack(spacing: 20) {
                ForEach(colors2, id: \.self) { color in
                    button(color: color)
                }
            }
            VStack(spacing: 20) {
                ForEach(colors3, id: \.self) { color in
                    button(color: color)
                }
            }
        }
    }
    
    func button(color: Color) -> some View {
        Button(action: {
            self.selectedColor = color
            self.drawingTool = .marker
        }) {
            Image(systemName: self.selectedColor == color ? "checkmark.circle.fill" : "circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: self.selectedColor == color ? 3 : 0)
                )
        }.accentColor(color)
    }
    
}

struct CustomColorPickerSample_Previews: PreviewProvider {
    static var previews: some View {
        CustomColorPickerSample()
    }
}
