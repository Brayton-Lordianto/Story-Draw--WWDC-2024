//
//  SwiftUIView.swift
//
//
//  Created by Brayton Lordianto on 4/14/23.
//
import SwiftUI
import PencilKit

enum tool {
case partialEraser
case wholeEraser
case marker
case pen
}

struct DrawSpace: View {
    @Binding var drawing: DrawingModel
    @Binding var canvas: PKCanvasView
    @Binding var isDraw: Bool
    @Binding var color: Color
    @Binding var drawingTool: tool
    
    let types: [PKInkingTool.InkType] = [.pencil, .pen, .marker]
    let names = ["Pencil", "Pen", "Marker"]
    let imageNames = ["pencil", "pencil.tip", "highlighter"]
    @State var offset = CGPoint()
    
    var body: some View {
            VStack(alignment: .leading) {
                DrawingViewRepresentable(canvas: $canvas, isDraw: $isDraw, color: $color, drawingTool: $drawingTool)
                    .aspectRatio(contentMode: .fill)
            }
            .ignoresSafeArea()
    }
    
    func addOverlaidImages() { 
            
    }
    
    func clearButton() -> some View {
        Button {
            canvas.drawing = PKDrawing()
        } label: {
            Text("CLEAR")
                .foregroundColor(.red)
        }
    }
    
    
    func currentModeButton() -> some View {
        Button {
            isDraw.toggle()
        } label: {
            let imageName = isDraw ? "eraser" : "pencil"
            let text = isDraw ? "eraser" : "pencil"
            return AnyView(VStack {
                Image(systemName: imageName)
                Text(text)
            })
        }
    }
    
    func colorPicker() -> some View {
        ColorPicker(selection: $color) {
            Label {
                Text("Color")
            } icon: {
                Image(systemName: "eyedropper.fill")
            }
        }
    }
    
    func switchToTool(_ newTool: tool) {
        drawingTool = newTool
    }
}

struct DrawingViewRepresentable : UIViewRepresentable {
    
    var canvas: Binding<PKCanvasView>
    var isDraw: Binding<Bool>
    
    var color: Binding<Color>
    var drawingTool: Binding<tool>
    
    
    var inkThick: PKInkingTool {
        PKInkingTool(.marker, color: UIColor(color.wrappedValue))
    }
    
    var inkThin: PKInkingTool {
        PKInkingTool(.fountainPen, color: UIColor(color.wrappedValue))
    }
    
    let partialEraser = PKEraserTool(.bitmap)
    let wholeEraser = PKEraserTool(.vector)
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.wrappedValue.backgroundColor = .black
        canvas.wrappedValue.drawingPolicy = .anyInput
        if drawingTool.wrappedValue == .marker {
            canvas.wrappedValue.tool = inkThick
        } else if drawingTool.wrappedValue == .partialEraser {
            canvas.wrappedValue.tool = partialEraser
        } else {
            canvas.wrappedValue.tool = wholeEraser
        }
        
        return canvas.wrappedValue
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if drawingTool.wrappedValue == .marker {
            canvas.wrappedValue.tool = inkThick
        } else if drawingTool.wrappedValue == .partialEraser {
            canvas.wrappedValue.tool = partialEraser
        } else if drawingTool.wrappedValue == .wholeEraser {
            canvas.wrappedValue.tool = wholeEraser
        } else {
            canvas.wrappedValue.tool = inkThin
        }
    }
}
