//
//  SwiftUIView.swift
//
//
//  Created by Brayton Lordianto on 4/14/23.
//

import SwiftUI
import PencilKit

struct CanvasView: View {
    @StateObject var drawingViewModel = DrawingViewModel()
    @State var uiimage = UIImage()
    var body: some View {
            VStack {
                CanvasRepresentable(uiimage: $uiimage)
                    .environmentObject(drawingViewModel)
                    .offset(y: 10)
                    .ignoresSafeArea(edges: .bottom)
                    .onAppear {
                        drawingViewModel.initializeCanvas()
                    }
            }
    }
}


// canvas representable
struct CanvasRepresentable: UIViewRepresentable {
    @EnvironmentObject var drawingViewModel: DrawingViewModel
    @Binding var uiimage: UIImage

    func makeUIView(context: Context) -> PKCanvasView {
        drawingViewModel.drawingModel.canvas.drawingPolicy = .anyInput
        return drawingViewModel.drawingModel.canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
    }
}


