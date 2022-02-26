//
//  CGFloatExtensions.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 22/1/22.
//

import CoreGraphics

extension CGFloat {
    func isWithin(min: CGFloat, max: CGFloat) -> Bool {
        self >= min && self <= max
    }
}
