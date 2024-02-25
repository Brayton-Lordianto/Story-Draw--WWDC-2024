import SwiftUI

struct CanvasView: View {
    @Binding var drawing: DrawingModel
    @State var imageToOverlay: UIImage? = nil
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
            }
            .edgesIgnoringSafeArea(.top)
        } detail: {
            DrawSpace(drawing: $drawing, canvas: $drawing.canvas, isDraw: $isDraw, color: $color, drawingTool: $drawingTool)
        }
        .overlay {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Chat(imageToOverlay: $imageToOverlay, drawing: $drawing, STIManager: .init(drawing: $drawing))  
                        .padding(100)
                }
            }
        }
        .onChange(of: imageToOverlay) { oldValue, newValue in
            if let image = newValue { 
                drawing.overlayImage(image: image)
            }
        }
    }
}

#Preview { 
    CanvasView(drawing: .constant(sampleDrawing))
}
