import Foundation
import PencilKit

struct DrawingModel {
    var canvas: PKCanvasView
    var name: String
    var isSelected: Bool = false
    var overlaidImages = [overlaidImage]()
    var idImage = UIImage()
    
    struct overlaidImage { 
        var image: UIImage
        var center = CGPoint()
        var scale = CGAffineTransform(scaleX: 1, y: 1)
        var rotation = CGAffineTransform(rotationAngle: 0)
    }
}

let sampleDrawing: DrawingModel = .init(canvas: .init(), name: "Untitled")

class DrawingViewModel: ObservableObject {
    @Published var drawings = [DrawingModel]()
    public let cellsPerRow = 3
    
    init() {
        // let drawings be of size
        for _ in 0..<4 {
            addDrawing()
        }
    }
    
    // c d drawings
    func addDrawing() {
        drawings.append(DrawingModel(canvas: PKCanvasView(), name: "Untitled"))
    }
    
    func removeDrawing(at index: Int) {
        drawings.remove(at: index)
    }
    
    func rowCount() -> Int {
        return drawings.count / cellsPerRow
    }
    
    func index(row: Int, col: Int) -> Int {
        return row * cellsPerRow + col
    }
}
//
//extension DrawingModel { 
//    func newOverlaidImage(image: UIImage) -> DrawingModel.overlaidImage {
//        let element = overlaidImage(image: image)
//        overlaidImages.append(overlaidImage)
//        return element
//    }
//}
