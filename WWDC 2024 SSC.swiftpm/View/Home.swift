//
//  File.swift
//
//
//  Created by Brayton Lordianto on 2/23/24.
//

import Foundation
import SwiftUI
import PencilKit

struct Home: View {
    @StateObject var drawingViewModel = DrawingViewModel()
    var body: some View {
        NavigationStack {
            Grid {
                ForEach(0..<10) { row in
                    GridRow {
                        ForEach(0..<drawingViewModel.cellsPerRow) { column in
                            if drawingViewModel.index(row: row, col: column) <= drawingViewModel.drawings.count {
                                NavigationLink(value: drawingViewModel.index(row: row, col: column)) {
                                    Text("Drawing Link")
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                    }
                }
            }
            
            .navigationDestination(for: Int.self) { index in
                CanvasView(canvas: $drawingViewModel.drawings[index].drawing)
            }
//            CanvasView(canvas: drawingViewModel.drawings[0].drawing)
//                .onAppear {
//                    drawingViewModel.addDrawing()
//                }
//            ForEach(drawings) { drawing in
//                NavigationLink(destination: CanvasView(drawingViewModel: drawing)) {
//                    Text("Drawing")
//                }
//            }
//
//            .navigationDestination(for: Int.self) { item in
//                CanvasView(drawingViewModel: drawings)
//            }
        }
        
        // function that takes in a view
        
    }
}
