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
    @State var drawings = [PKCanvasView()]
    var body: some View {
        NavigationStack {
//            Text("")
            CanvasView(canvas: $drawings[0])
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
    }
}
