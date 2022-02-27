//
//  StaticTriangularPhysicsBody.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//

import CoreGraphics

class StaticTriangularPhysicsBody: PhysicsBody, PolygonalIntersector, TriangularIntersector {
    private(set) var width: Double
    private(set) var height: Double
    private(set) var rotation: Double

    init(gameObjectType: GameObjectType, position: CGVector, width: Double, height: Double, rotation: Double) {
        self.width = width
        self.height = height
        self.rotation = rotation
        super.init(gameObjectType: gameObjectType, position: position)
    }
}
