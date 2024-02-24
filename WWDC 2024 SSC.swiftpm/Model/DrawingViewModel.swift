import Foundation
import PencilKit

struct DrawingModel {
    var drawing: PKCanvasView
    var name: String
}

class DrawingViewModel: ObservableObject {
    @Published var drawings = [DrawingModel]()
    public let cellsPerRow = 3
    
    init() {
        // let drawings be of size 10
        for _ in 0..<10 {
            addDrawing()
        }
    }
    
    // c d drawings
    func addDrawing() {
        drawings.append(DrawingModel(drawing: PKCanvasView(), name: "Untitled"))
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
