//
//  File.swift
//  
//
//  Created by Brayton Lordianto on 2/24/24.
//

import Foundation
import SwiftUI

extension DrawingViewModel {
    func extractImage(index: Int) -> UIImage {
        let canvas = drawings[index].canvas
        let drawing = canvas.drawing
        let bounds = drawing.bounds
        let image = drawing.image(from: bounds, scale: 1).withBackground(color: .black)
        return image
    }
}

extension UIImage {
  func withBackground(color: UIColor, opaque: Bool = true) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        
    guard let ctx = UIGraphicsGetCurrentContext(), let image = cgImage else { return self }
    defer { UIGraphicsEndImageContext() }
        
    let rect = CGRect(origin: .zero, size: size)
    ctx.setFillColor(color.cgColor)
    ctx.fill(rect)
    ctx.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height))
    ctx.draw(image, in: rect)
        
    return UIGraphicsGetImageFromCurrentImageContext() ?? self
  }
}
