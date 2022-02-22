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

    private(set) var width = Constants.blockWidth
    private(set) var height = Constants.blockHeight
    private(set) var center: CGVector
    private(set) var topVertex: CGVector
    private(set) var leftVertex: CGVector
    private(set) var rightVertex: CGVector
    private(set) var rotation = 0.0

    convenience init(color: PeggleColor, center: CGVector) {
        self.init(uuid: UUID(), color: color, center: center)
    }

    init(uuid: UUID, color: PeggleColor, center: CGVector) {
        self.uuid = uuid
        self.color = color
        self.center = center
        topVertex = CGVector(dx: center.dx, dy: center.dy - height / 2)
            .rotate(by: rotation, origin: center)
        leftVertex = CGVector(dx: center.dx - width / 2, dy: center.dy + height / 2)
            .rotate(by: rotation, origin: center)
        rightVertex = CGVector(dx: center.dx + width / 2, dy: center.dy + height / 2)
            .rotate(by: rotation, origin: center)
    }

    func changeCenter(to center: CGVector) {
        self.center = center
        resetVertices()
    }

    func changeWidth(to width: Double) {
        self.width = width
        resetVertices()
    }

    func changeHeight(to height: Double) {
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
        [topVertex, leftVertex, rightVertex]
    }

    var edges: [Line] {
        [
            Line(start: topVertex, end: rightVertex),
            Line(start: rightVertex, end: leftVertex),
            Line(start: leftVertex, end: topVertex)
        ]
    }
}
