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
            Grid(alignment: .leading) {
                ForEach(0..<10) { row in
                    GridRow {
                        ForEach(0..<drawingViewModel.cellsPerRow) { column in
                            let index = drawingViewModel.index(row: row, col: column)
                            if index < drawingViewModel.drawings.count {
                                Spacer()
                                navigationLink(index: index)
                                Spacer()
                            }
                        }
                    }
                }
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: drawingViewModel.addDrawing) {
                        VStack {
                            Image(systemName: "plus")
                            Text("Add New")
                        }
                    }.foregroundStyle(.blue)
                }
            }
            .navigationDestination(for: Int.self) { index in
                CanvasView(drawing: $drawingViewModel.drawings[index])
            }
            .navigationTitle("Drawings").navigationBarTitleDisplayMode(.large)
        }
    }
        
    func navigationLink(index: Int) -> some View {
        NavigationLink(value: index) {
            VStack {
                Image(uiImage: drawingViewModel.extractImage(index: index))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                Text(drawingViewModel.drawings[index].name)
                    .foregroundStyle(.black)
            }
        }
    }

}
