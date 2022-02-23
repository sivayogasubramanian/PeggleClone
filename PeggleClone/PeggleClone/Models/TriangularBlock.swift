//
//  TriangularBlock.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 20/2/22.
//

import Foundation
import CoreGraphics

final class TriangularBlock: Identifiable {
    let uuid: UUID
    let color: PeggleColor

    private(set) var width: Double
    private(set) var height: Double
    private(set) var center: CGVector
    private(set) var rotation: Double

    convenience init(color: PeggleColor, center: CGVector, width: Double, height: Double, rotation: Double) {
        self.init(uuid: UUID(), color: color, center: center, width: width, height: height, rotation: rotation)
    }

    init(uuid: UUID, color: PeggleColor, center: CGVector, width: Double, height: Double, rotation: Double) {
        self.uuid = uuid
        self.color = color
        self.center = center
        self.width = width
        self.height = height
        self.rotation = rotation
    }

    func setCenter(to center: CGVector) {
        self.center = center
    }

    func setWidth(to width: Double) {
        self.width = width
    }

    func setHeight(to height: Double) {
        self.height = height
    }

    func setRotation(to rotation: Double) {
        self.rotation = rotation
    }
}

extension TriangularBlock: PolygonIntersector {
    var topVertex: CGVector {
        CGVector(dx: center.dx, dy: center.dy - height / 2)
            .rotate(by: rotation, origin: center)
    }

    var leftVertex: CGVector {
        CGVector(dx: center.dx - width / 2, dy: center.dy + height / 2)
            .rotate(by: rotation, origin: center)
    }

    var rightVertex: CGVector {
        CGVector(dx: center.dx + width / 2, dy: center.dy + height / 2)
            .rotate(by: rotation, origin: center)
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
