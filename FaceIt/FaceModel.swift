//
//  FacialExpression.swift
//  FaceIt
//
//  Created by CS193p Instructor.
//  Copyright © 2015-17 Stanford University. All rights reserved.
//
import Foundation

// UI-independent representation of a facial expression
struct FaceModel {
    
    enum Eyes: Int {
        case open
        case closed
        case squinting
    }
    
    enum Mouth: Int {
        case frown
        case smirk
        case neutral
        case grin
        case smile
        var sadder: Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .frown
        }
        var happier: Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .smile
        }
    }
    
    var sadder: FaceModel {
        return FaceModel(eyes: self.eyes, mouth: self.mouth.sadder)
    }
    
    var happier: FaceModel {
        return FaceModel(eyes: self.eyes, mouth: self.mouth.happier)
    }
    
    let eyes: Eyes
    
    let mouth: Mouth
}
