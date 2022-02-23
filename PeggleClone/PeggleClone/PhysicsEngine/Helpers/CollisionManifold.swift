//
//  CollisionManifold.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 23/2/22.
//

import Foundation
import CoreGraphics

struct CollisionManifold {
    static let zero = CollisionManifold(hasCollided: false, normal: .zero, depth: .zero)

    let hasCollided: Bool
    let normal: CGVector
    let depth: Double
}
