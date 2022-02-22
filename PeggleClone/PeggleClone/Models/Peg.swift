//
//  Peg.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 20/1/22.
//

import CoreGraphics
import Foundation

final class Peg: Identifiable {
    let uuid: UUID
    let color: PeggleColor
    private(set) var center: CGVector
    private(set) var radius: Double
    private(set) var rotation: Double
    var diameter: Double {
        radius * 2
    }

    convenience init(color: PeggleColor, center: CGVector, radius: Double, rotation: Double) {
        self.init(uuid: UUID(), color: color, center: center, radius: radius, rotation: rotation)
    }

    init(uuid: UUID, color: PeggleColor, center: CGVector, radius: Double, rotation: Double) {
        self.uuid = uuid
        self.color = color
        self.center = center
        self.radius = radius
        self.rotation = rotation
    }

    func setCenter(to center: CGVector) {
        self.center = center
    }

    func setRotation(to rotation: Double) {
        self.rotation = rotation
    }

    func setRadius(to radius: Double) {
        self.radius = radius
    }
}

extension Peg: CircularIntersector {
}
