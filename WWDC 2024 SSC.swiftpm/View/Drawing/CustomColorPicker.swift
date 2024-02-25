//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 2/24/24.
//

import SwiftUI
import PencilKit

struct CustomColorPickerSample: View {
    @State private var selectedColor = Color.blue
    @State var isDraw: tool = .marker
    var body: some View {
        ZStack {
            CustomColorPicker(selectedColor: $selectedColor, drawingTool: $isDraw)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CustomColorPicker: View {
    @Binding var selectedColor: Color
    @Binding var drawingTool: tool
    let colors: [Color] = [.white,
                           .purple,
                           .red,
                           .orange]
    let colors2: [Color] = [.yellow,
                            .green,
                            .pink,
                            .cyan]
    let colors3: [Color] = [.mint,
                            .indigo,
                            .teal,
                            .blue]
    var body: some View {
        HStack(spacing: 10) {
            VStack(spacing: 20) {
                ForEach(colors, id: \.self) { color in
                    button(color: color)
                }
            }
            VStack(spacing: 20) {
                ForEach(colors2, id: \.self) { color in
                    button(color: color)
                }
            }
            VStack(spacing: 20) {
                ForEach(colors3, id: \.self) { color in
                    button(color: color)
                }
            }
        }
    }
    
    func button(color: Color) -> some View {
        Button(action: {
            self.selectedColor = color
            self.drawingTool = .marker
        }) {
            Image(systemName: self.selectedColor == color ? "checkmark.circle.fill" : "circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: self.selectedColor == color ? 3 : 0)
                )
        }.accentColor(color)
    }
    
}

struct CustomColorPickerSample_Previews: PreviewProvider {
    static var previews: some View {
        CustomColorPickerSample()
    }
}
