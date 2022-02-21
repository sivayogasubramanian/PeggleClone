//
//  LinePhysicsBody.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 20/2/22.
//

import Foundation
import CoreGraphics

class LinePhysicsBody: PhysicsBody, LineIntersector {
    let line: Line

    init(start: CGVector, end: CGVector) {
        line = Line(start: start, end: end)
        let length = (start - end).length()
        let center = start * (length / 2)
        super.init(gameObjectType: .line, position: center)
    }

    func closestPointOnLine(to point: CGVector) -> CGVector {
        line.closestPointOnLine(to: point)
    }

    func shortestDistance(from point: CGVector) -> Double {
        line.shortestDistance(from: point)
    }
}
