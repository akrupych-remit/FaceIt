//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Andriy Krupych on 4/25/17.
//  Copyright © 2017 Andriy Krupych. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationVC = segue.destination as! UINavigationController
        let destinationVC = navigationVC.visibleViewController as! FaceViewController
        var model = FaceModel(eyes: .open, mouth: .neutral)
        switch segue.identifier! {
            case "sad": model = FaceModel(eyes: .closed, mouth: .frown)
            case "happy": model = FaceModel(eyes: .open, mouth: .smile)
            case "worried": model = FaceModel(eyes: .open, mouth: .smirk)
            default: break
        }
        destinationVC.faceModel = model
        destinationVC.navigationItem.title = (sender as! UIButton).currentTitle
    }

}
