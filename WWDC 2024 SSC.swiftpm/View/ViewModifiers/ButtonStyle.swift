//
//  SwiftUIView.swift
//  
//
//  Created by Brayton Lordianto on 2/24/24.
//
import SwiftUI

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 250)
            .background(Color(.systemTeal))
            .foregroundColor(.black)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .padding(.bottom, 10)
    }
}
