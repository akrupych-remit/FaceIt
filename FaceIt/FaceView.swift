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
    
    enum Side {
        case left
        case right
    }
    
    enum EyeType {
        case circle
        case line
        case arc(clockwise: Bool)
    }
    
    @IBInspectable
    var fillColor: UIColor = UIColor.yellow
    @IBInspectable
    var strokeColor: UIColor = UIColor.black
    @IBInspectable
    var strokeWidth: Int = 5
    @IBInspectable
    var scale: CGFloat = 0.9
    
    private var faceRadius: CGFloat {
        return min(self.bounds.width, self.bounds.height) * self.scale
    }
    private var faceCenter: CGPoint {
        return CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    }
    
    lazy var mouthCurvity: Float = 1
    var eyes: Dictionary<Side, EyeType> = [.left : .circle, .right : .circle]
    
    func onPinch(recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .changed, .ended:
            scale *= recognizer.scale
            recognizer.scale = 1
            setNeedsDisplay()
        default:
            break
        }
    }

    override func draw(_ rect: CGRect) {
        drawFaceOval()
        drawEye(side: .left)
        drawEye(side: .right)
        drawMouth()
    }
    
    private func drawFaceOval() {
        let faceOvalPath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius / 2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        faceOvalPath.lineWidth = CGFloat(strokeWidth)
        strokeColor.set()
        faceOvalPath.stroke()
        fillColor.set()
        faceOvalPath.fill()
    }
    
    private func drawEye(side: Side) {
        let position: CGPoint
        switch side {
        case .left:
            position = CGPoint(x: faceCenter.x - faceRadius / 5, y: faceCenter.y - faceRadius / 8)
        case .right:
            position = CGPoint(x: faceCenter.x + faceRadius / 5, y: faceCenter.y - faceRadius / 8)
        }
        let eyePath: UIBezierPath
        switch eyes[side]! {
        case .circle:
            eyePath = UIBezierPath(arcCenter: position, radius: 10, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        case .line:
            eyePath = UIBezierPath()
            eyePath.move(to: CGPoint(x: position.x - CGFloat(strokeWidth * 2), y: position.y))
            eyePath.addLine(to: CGPoint(x: position.x + CGFloat(strokeWidth * 2), y: position.y))
        case .arc(let clockwise):
            eyePath = UIBezierPath(arcCenter: position, radius: 10, startAngle: 0, endAngle: CGFloat.pi, clockwise: clockwise)
        }
        eyePath.lineWidth = CGFloat(strokeWidth)
        strokeColor.set()
        eyePath.stroke()
    }
    
    private func drawMouth() {
//        let mouth = UIBezierPath(arcCenter: faceCenter, radius: faceRadius / 4, startAngle: CGFloat.pi / 4, endAngle: CGFloat.pi * 3 / 4, clockwise: true)
        let mouthPath = UIBezierPath()
        let neutralY = center.y + faceRadius / 4
        mouthPath.move(to: CGPoint(x: center.x - faceRadius / 4, y: center.y + faceRadius / 4))
        mouthPath.addQuadCurve(to: CGPoint(x: center.x + faceRadius / 4, y: center.y + faceRadius / 4),
                               controlPoint: CGPoint(x: center.x, y: neutralY + self.faceRadius * CGFloat(mouthCurvity / 4)))
        mouthPath.lineWidth = CGFloat(strokeWidth)
        strokeColor.set()
        mouthPath.stroke()
    }
	
}
