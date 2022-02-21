//
//  PolygonalPhysicsBody.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//

import Foundation
import CoreGraphics

class PolygonalPhysicsBody: PhysicsBody, PolygonIntersector {
    private(set) var vertices: [CGVector]
    private(set) var edges: [Line]

    init(gameObjectType: GameObjectType, position: CGVector, vertices: [CGVector], edges: [Line]) {
        self.vertices = vertices
        self.edges = edges
        super.init(gameObjectType: gameObjectType, position: position)
    }
}
