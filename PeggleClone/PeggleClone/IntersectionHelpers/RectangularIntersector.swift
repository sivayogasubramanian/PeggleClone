//
//  RectangularIntersector.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/2/22.
//

import CoreGraphics

protocol RectangularIntersector {
    var width: Double { get }
    var height: Double { get }
    var position: CGVector { get }
    var rotation: Double { get }
    var vertices: [CGVector] { get }
    var edges: [Line] { get }
}

extension RectangularIntersector {
    var topLeftVertex: CGVector {
        CGVector(dx: position.dx - width / 2, dy: position.dy - height / 2)
            .rotate(by: rotation, origin: position)
    }

    var topRightVertex: CGVector {
        CGVector(dx: position.dx + width / 2, dy: position.dy - height / 2)
            .rotate(by: rotation, origin: position)
    }

    var bottomLeftVertex: CGVector {
        CGVector(dx: position.dx - width / 2, dy: position.dy + height / 2)
            .rotate(by: rotation, origin: position)
    }

    var bottomRightVertex: CGVector {
        CGVector(dx: position.dx + width / 2, dy: position.dy + height / 2)
            .rotate(by: rotation, origin: position)
    }

    var vertices: [CGVector] {
        [topLeftVertex, topRightVertex, bottomRightVertex, bottomLeftVertex]
    }

    var edges: [Line] {
        [
            Line(start: topLeftVertex, end: topRightVertex),
            Line(start: topRightVertex, end: bottomRightVertex),
            Line(start: bottomRightVertex, end: bottomLeftVertex),
            Line(start: bottomLeftVertex, end: topLeftVertex)
        ]
    }
}
