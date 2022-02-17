//
//  CircularBody.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 4/2/22.
//

import Foundation
import CoreGraphics

class CircularPhysicsBody: PhysicsBody {
    private(set) var radius: Double
    var center: CGVector {
        super.position
    }

    init(gameObjectType: GameObjectType, position: CGVector, radius: Double) {
        self.radius = radius
        super.init(gameObjectType: gameObjectType, position: position)
    }

    init(gameObjectType: GameObjectType, position: CGVector, radius: Double, mass: Double) {
        self.radius = radius
        super.init(gameObjectType: gameObjectType, position: position, mass: mass)
    }
}
