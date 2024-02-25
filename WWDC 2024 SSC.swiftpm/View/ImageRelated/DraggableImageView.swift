import SwiftUI

// we have to not only make this draggable, but rotatable and zoomable 
class DraggableImageView: UIImageView {
    var beganPoint: CGPoint? = nil
    var originCenter: CGPoint? = nil
    
    override init(image: UIImage?) {
        super.init(image: image)
        setupGestureRecognizers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGestureRecognizers()
    }
    
    private func setupGestureRecognizers() {
        // Add UIPinchGestureRecognizer to the view
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
        self.addGestureRecognizer(pinchGestureRecognizer)
        self.addGestureRecognizer(rotateGestureRecognizer)
    }
    
    @objc func handlePinch(_ gestureRecognizer: UIPinchGestureRecognizer) {
        let scale = gestureRecognizer.scale
        self.transform = self.transform.scaledBy(x: scale, y: scale)
        gestureRecognizer.scale = 1.0
        center = gestureRecognizer.location(in: superview)
    }
    
    @objc func handleRotation(_ gestureRecognizer: UIRotationGestureRecognizer) { 
        let angle = gestureRecognizer.rotation
        print(angle)
        self.transform = self.transform.rotated(by: angle)
        gestureRecognizer.rotation = 0
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("began ")
        if let position = touches.first?.location(in: superview){
            beganPoint = position
            originCenter = center
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        // delete if tapped many times  
        if let taps = touch?.tapCount, taps >= 2 { 
            self.removeFromSuperview()
            return 
        } 
        
        // update location
        if let position = touch?.location(in: superview),
           let beganX = beganPoint?.x,
           let beganY = beganPoint?.y,
           let originX = originCenter?.x,
           let originY = originCenter?.y
        {
            let newPosition = CGPoint(x: position.x - beganX, y: position.y - beganY)
            center = CGPoint(x: originX + newPosition.x, y: originY + newPosition.y)
        }
        
    }
}
