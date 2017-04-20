//
//  ViewController.swift
//  FaceIt
//
//  Created by Andriy Krupych on 4/20/17.
//  Copyright © 2017 Andriy Krupych. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            updateView()
        }
    }
    
    private var facialExpression: FacialExpression = FacialExpression(eyes: .open, mouth: .smile) {
        didSet {
            updateView()
        }
    }
    
    private let eyesMapping: Dictionary<FacialExpression.Eyes, FaceView.EyeType> = [
        .open : .circle,
        .closed : .line,
        .squinting : .arc(clockwise: false)
    ]
    
    private let mouthMapping: Dictionary<FacialExpression.Mouth, Float> = [
        .frown : -1,
        .grin : -0.5,
        .neutral : 0,
        .smirk : 0.5,
        .smile : 1
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    private func updateView() {
        faceView.eyes[.left] = eyesMapping[facialExpression.eyes]
        faceView.eyes[.right] = eyesMapping[facialExpression.eyes]
        faceView.mouthCurvity = mouthMapping[facialExpression.mouth]!
    }

}

