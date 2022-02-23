//
//  SHMTriangularPhysicsBody.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 23/2/22.
//

import Foundation
import CoreGraphics

class SHMTriangularPhysicsBody: PhysicsBody, TriangularIntersector {
    private static var minimumSpringiness = 100.0
    private static var maximumSpringiness = 25.0

    private(set) var width: Double
    private(set) var height: Double
    private(set) var rotation: Double
    private(set) var springiness: Double
    private(set) var originalPosition: CGVector

    init(gameObjectType: GameObjectType, position: CGVector, width: Double,
         height: Double, rotation: Double, springiness: Double
    ) {
        self.width = width
        self.height = height
        self.rotation = rotation
        originalPosition = position
        self.springiness = abs(300 - springiness)
        super.init(gameObjectType: gameObjectType, position: position, mass: 2)
    }

    override func updatePhysicsBody(dt deltaTime: TimeInterval) {
        guard velocity.lengthSquared() != 0 else {
            return
        }

        let distance = (originalPosition - position).length()
        let direction = (originalPosition - position).normalize()
        let force = direction * springiness
        let acceleration = force * (1 / mass)
        setVelocity(to: velocity + acceleration)
        setPosition(to: position + (velocity * deltaTime))
        setVelocity(to: velocity * 0.995)

        if distance < 5 && velocity.length() < 50 {
            setPosition(to: originalPosition)
            setVelocity(to: .zero)
        }
    }
}
