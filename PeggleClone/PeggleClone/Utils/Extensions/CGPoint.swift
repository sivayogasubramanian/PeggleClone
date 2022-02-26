//
//  CGPointExtensions.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 22/1/22.
//

import CoreGraphics

extension CGPoint {
    func distance(toPoint: CGPoint) -> CGFloat {
        hypot(x - toPoint.x, y - toPoint.y)
    }

    func isWithinBounds(minX: CGFloat, maxX: CGFloat, minY: CGFloat, maxY: CGFloat) -> Bool {
        x.isWithin(min: minX, max: maxX) && y.isWithin(min: minY, max: maxY)
    }
}

// MARK: Converters
extension CGPoint {
    func toCGVector() -> CGVector {
        CGVector(dx: x, dy: y)
    }
}
