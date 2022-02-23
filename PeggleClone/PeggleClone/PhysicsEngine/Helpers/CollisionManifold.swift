//
//  CollisionManifold.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 23/2/22.
//

import Foundation
import CoreGraphics

struct CollisionManifold {
    static let zero = CollisionManifold(normal: .zero, depth: .zero)

    let normal: CGVector
    let depth: Double
}
