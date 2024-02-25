import SwiftUI

struct CanvasView: View {
    @Binding var drawing: DrawingModel
    @State var isDraw = true
    @State var color = Color.white
    @State var drawingTool: tool = .pen
    @State var showingSecondScreen = false
    @State var lastURL = ""
    
    @State var showingImagePicker: Bool = false
    @State var uploadedImage: UIImage? = nil
    
    var body: some View {
        NavigationSplitView {
            ZStack {
                Color.brown
                CanvasMenu(toolSelection: $drawingTool, color: $color, drawing: $drawing)
            }.ignoresSafeArea()
        } detail: {
            // drawing view should take 80% of the screen
            DrawSpace(drawing: $drawing, canvas: $drawing.canvas, isDraw: $isDraw, color: $color, drawingTool: $drawingTool)
        }
        .overlay {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Chat()  
                        .padding(100)
                }
            }
        }
    }
}

#Preview { 
    CanvasView(drawing: .constant(sampleDrawing))
}
