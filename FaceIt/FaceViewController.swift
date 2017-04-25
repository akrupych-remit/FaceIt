//
//  ViewController.swift
//  FaceIt
//
//  Created by Andriy Krupych on 4/20/17.
//  Copyright © 2017 Andriy Krupych. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.onPinch)))
            faceView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFaceTaped)))
            let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeUp))
            swipeUp.direction = .up
            faceView.addGestureRecognizer(swipeUp)
            let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeDown))
            swipeDown.direction = .down
            faceView.addGestureRecognizer(swipeDown)
            updateView()
        }
    }
    
    var faceModel: FaceModel = FaceModel(eyes: .open, mouth: .neutral) {
        didSet {
            updateView()
        }
    }
    
    private let eyesMapping: Dictionary<FaceModel.Eyes, FaceView.EyeType> = [
        .open : .circle,
        .closed : .line,
        .squinting : .arc(clockwise: false)
    ]
    
    private let mouthMapping: Dictionary<FaceModel.Mouth, Float> = [
        .frown : -1,
        .smirk : -0.5,
        .neutral : 0,
        .grin : 0.5,
        .smile : 1
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    private func updateView() {
        guard faceView != nil else { return }
        faceView.eyes[.left] = eyesMapping[faceModel.eyes]
        faceView.eyes[.right] = eyesMapping[faceModel.eyes]
        faceView.mouthCurvity = mouthMapping[faceModel.mouth]!
        faceView.setNeedsDisplay()
    }
    
    func onFaceTaped(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            faceModel = FaceModel(eyes: faceModel.eyes == .open ? .closed : .open, mouth: faceModel.mouth)
        }
    }
    
    func onSwipeUp(recognizer: UISwipeGestureRecognizer) {
        faceModel = faceModel.sadder
    }
    
    func onSwipeDown(recognizer: UISwipeGestureRecognizer) {
        faceModel = faceModel.happier
    }

}

