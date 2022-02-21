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
    private(set) var radius = Constants.pegRadius
    var diameter: Double {
        radius * 2
    }

    convenience init(color: PeggleColor, center: CGVector) {
        self.init(uuid: UUID(), color: color, center: center)
    }

    init(uuid: UUID, color: PeggleColor, center: CGVector) {
        self.uuid = uuid
        self.color = color
        self.center = center
    }

    func changeCenter(to center: CGVector) {
        self.center = center
    }

    func changeRadius(to radius: Double) {
        self.radius = radius
    }
}

extension Peg: CircularIntersector {
}
