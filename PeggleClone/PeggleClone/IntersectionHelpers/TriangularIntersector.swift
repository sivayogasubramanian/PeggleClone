//
//  PolygonIntersector.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//

import Foundation
import CoreGraphics

protocol TriangularIntersector {
    var width: Double { get }
    var height: Double { get }
    var position: CGVector { get }
    var rotation: Double { get }
}

extension TriangularIntersector {
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
