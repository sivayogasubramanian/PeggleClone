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
    private(set) var topVertex: CGVector
    private(set) var leftVertex: CGVector
    private(set) var rightVertex: CGVector
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

        topVertex = CGVector(dx: center.dx, dy: center.dy - height / 2)
            .rotate(by: rotation, origin: center)
        leftVertex = CGVector(dx: center.dx - width / 2, dy: center.dy + height / 2)
            .rotate(by: rotation, origin: center)
        rightVertex = CGVector(dx: center.dx + width / 2, dy: center.dy + height / 2)
            .rotate(by: rotation, origin: center)
    }

    func setCenter(to center: CGVector) {
        self.center = center
        resetVertices()
    }

    func setWidth(to width: Double) {
        self.width = width
        resetVertices()
    }

    func setHeight(to height: Double) {
        self.height = height
        resetVertices()
    }

    func setRotation(to rotation: Double) {
        self.rotation = rotation
        resetVertices()
    }

    private func resetVertices() {
        topVertex = CGVector(dx: center.dx, dy: center.dy - height / 2)
            .rotate(by: rotation, origin: center)
        leftVertex = CGVector(dx: center.dx - width / 2, dy: center.dy + height / 2)
            .rotate(by: rotation, origin: center)
        rightVertex = CGVector(dx: center.dx + width / 2, dy: center.dy + height / 2)
            .rotate(by: rotation, origin: center)
    }
}

extension TriangularBlock: PolygonIntersector {
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
