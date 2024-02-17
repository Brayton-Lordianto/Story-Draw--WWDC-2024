import Foundation
import PencilKit

struct DrawingModel {
    var canvas: PKCanvasView
    var toolPicker: PKToolPicker
    
    init() {
        self.canvas = PKCanvasView()
        self.toolPicker = PKToolPicker()
     }
}

class DrawingViewModel: ObservableObject {
    @Published var drawingModel: DrawingModel
    
    init() {
        self.drawingModel = DrawingModel()
    }

    // initialize the canvas
    func initializeCanvas() {
        // basic settings
        drawingModel.canvas.drawingPolicy = .anyInput
        drawingModel.canvas.backgroundColor = .clear
        
        // make a black border background around the canvas
        drawingModel.canvas.layer.borderColor = UIColor.blue.cgColor
        drawingModel.canvas.layer.borderWidth = 5
        
        
        // set up a built in tool picker
        drawingModel.toolPicker.setVisible(true, forFirstResponder: drawingModel.canvas)
        drawingModel.toolPicker.addObserver(drawingModel.canvas)
        drawingModel.canvas.becomeFirstResponder()
        drawingModel.toolPicker.setVisible(true, forFirstResponder: drawingModel.canvas)
    }
    
    //  return the drawing as a UIImage
    func drawingAsImage() -> UIImage {
        let image = drawingModel.canvas.drawing.image(from: drawingModel.canvas.drawing.bounds, scale: 1)
        return image
    }
}
