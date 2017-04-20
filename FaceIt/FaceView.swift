//
//  FaceView.swift
//  FaceIt
//
//  Created by Andriy Krupych on 4/20/17.
//  Copyright © 2017 Andriy Krupych. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    
    @IBInspectable
    var fillColor: UIColor = UIColor.yellow
    
    @IBInspectable
    var strokeColor: UIColor = UIColor.black
    
    private lazy var faceRadius: CGFloat = min(self.bounds.width, self.bounds.height) - 40
    
    private lazy var faceCenter: CGPoint = CGPoint(x: self.bounds.midX, y: self.bounds.midY)

    override func draw(_ rect: CGRect) {
        
        // draw face oval
        let faceOval = UIBezierPath(arcCenter: faceCenter, radius: faceRadius / 2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        faceOval.lineWidth = 5
        strokeColor.set()
        faceOval.stroke()
        fillColor.set()
        faceOval.fill()
        
        // draw left eye
        let leftEyePosition = CGPoint(x: faceCenter.x - faceRadius / 5, y: faceCenter.y - faceRadius / 8)
        let leftEye = UIBezierPath(arcCenter: leftEyePosition, radius: 10, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        strokeColor.set()
        leftEye.fill()
        
        // draw right eye
        let rightEyePosition = CGPoint(x: faceCenter.x + faceRadius / 5, y: faceCenter.y - faceRadius / 8)
        let rightEye = UIBezierPath(arcCenter: rightEyePosition, radius: 10, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        strokeColor.set()
        rightEye.fill()
        
        // draw mouth
        let mouth = UIBezierPath(arcCenter: faceCenter, radius: faceRadius / 4, startAngle: CGFloat.pi / 4, endAngle: CGFloat.pi * 3 / 4, clockwise: true)
//        let mouth = UIBezierPath()
//        mouth.move(to: center)
//        mouth.addQuadCurve(to: CGPoint(x: center.x + 100, y: center.y + 200), controlPoint: CGPoint(x: center.x - 100, y: center.y + 200))
        mouth.lineWidth = 5
        strokeColor.set()
        mouth.stroke()
    }
	
}
