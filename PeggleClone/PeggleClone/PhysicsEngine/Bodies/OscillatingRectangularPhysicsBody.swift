//
//  OscillatingRectangularPhysicsBody.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/2/22.
//

import Foundation
import CoreGraphics

class OscillatingRectangularPhysicsBody: PhysicsBody, PolygonalIntersector, RectangularIntersector {
    private(set) var width: Double
    private(set) var height: Double
    private(set) var rotation: Double
    private(set) var originalPosition: CGVector

    init(gameObjectType: GameObjectType, position: CGVector, width: Double,
         height: Double, rotation: Double
    ) {
        self.width = width
        self.height = height
        self.rotation = rotation
        originalPosition = position
        super.init(gameObjectType: gameObjectType, position: position)
        setVelocity(to: CGVector(dx: -50, dy: 0), isMovable: true)
    }

    override func updatePhysicsBody(dt deltaTime: TimeInterval, isMovable: Bool) {
        setPosition(to: position + (velocity * deltaTime), isMovable: true)
        if position.distance(to: originalPosition) > 200 {
            setVelocity(to: -velocity, isMovable: true)
        }
    }
}
