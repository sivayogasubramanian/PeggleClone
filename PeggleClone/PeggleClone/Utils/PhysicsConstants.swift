//
//  PhysicsConstants.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 9/2/22.
//

import Foundation
import CoreGraphics

struct PhysicsConstants {
    static let ballMass = 2.0
    static let gravity = CGVector(dx: 0, dy: 9.81 * 2)
    static let coefficientOfRestitution = 0.8
    static let initialBallLaunchVelocityMultiplier = 950.0
    static let initialBallLaunchYCoordinate = 50.0
    static let physicsBodyMaxHitCount = 100
    static let physicsUpdateTickTime = 0.01
}
