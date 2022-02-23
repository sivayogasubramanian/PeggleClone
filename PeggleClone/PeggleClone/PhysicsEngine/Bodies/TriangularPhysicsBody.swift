//
//  PolygonalPhysicsBody.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//

import Foundation
import CoreGraphics

class TriangularPhysicsBody: PhysicsBody {
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

extension TriangularPhysicsBody: PolygonIntersector {
    var topVertex: CGVector {
        CGVector(dx: position.dx, dy: position.dy - height / 2)
            .rotate(by: rotation, origin: position)
    }

    var leftVertex: CGVector {
        CGVector(dx: position.dx - width / 2, dy: position.dy + height / 2)
            .rotate(by: rotation, origin: position)
    }

    var rightVertex: CGVector {
        CGVector(dx: position.dx + width / 2, dy: position.dy + height / 2)
            .rotate(by: rotation, origin: position)
    }

    var vertices: [CGVector] {
        [topVertex, rightVertex, leftVertex]
    }

    var edges: [Line] {
        [
            Line(start: topVertex, end: rightVertex),
            Line(start: rightVertex, end: leftVertex),
            Line(start: leftVertex, end: topVertex)
        ]
    }
}
