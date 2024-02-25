import Foundation
import PencilKit

struct DrawingModel {
    var canvas: PKCanvasView
    var name: String
    var isSelected: Bool = false
}

class DrawingViewModel: ObservableObject {
    @Published var drawings = [DrawingModel]()
    public let cellsPerRow = 3
    
    init() {
        // let drawings be of size
        for _ in 0..<1 {
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
