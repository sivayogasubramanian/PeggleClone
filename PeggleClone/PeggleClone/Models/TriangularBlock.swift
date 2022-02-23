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
    private(set) var springiness: Double

    convenience init(color: PeggleColor, center: CGVector, width: Double,
                     height: Double, rotation: Double, springiness: Double
    ) {
        self.init(uuid: UUID(), color: color, center: center,
                  width: width, height: height, rotation: rotation,
                  springiness: springiness)
    }

    init(uuid: UUID, color: PeggleColor, center: CGVector,
         width: Double, height: Double, rotation: Double, springiness: Double
    ) {
        self.uuid = uuid
        self.color = color
        self.center = center
        self.width = width
        self.height = height
        self.rotation = rotation
        self.springiness = springiness
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

    func setSpringiness(to springiness: Double) {
        self.springiness = springiness
    }
}

extension TriangularBlock: TriangularIntersector {
    var position: CGVector {
        center
    }
}
