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

    convenience init(color: PeggleColor, center: CGVector) {
        self.init(uuid: UUID(), color: color, center: center)
    }

    init(uuid: UUID, color: PeggleColor, center: CGVector) {
        self.uuid = uuid
        self.color = color
        self.center = center
        topVertex = CGVector(dx: center.dx, dy: center.dy - height / 2)
        leftVertex = CGVector(dx: center.dx - width / 2, dy: center.dy + height / 2)
        rightVertex = CGVector(dx: center.dx + width / 2, dy: center.dy + height / 2)
    }

    func changeCenter(to center: CGVector) {
        self.center = center
        setVertices()
    }

    func changeWidth(to width: Double) {
        self.width = width
        setVertices()
    }

    func changeHeight(to height: Double) {
        self.height = height
        setVertices()
    }

    private func setVertices() {
        topVertex = CGVector(dx: center.dx, dy: center.dy - height / 2)
        leftVertex = CGVector(dx: center.dx - width / 2, dy: center.dy + height / 2)
        rightVertex = CGVector(dx: center.dx + width / 2, dy: center.dy + height / 2)
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
