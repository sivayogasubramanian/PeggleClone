//
//  PowerupMapping.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/2/22.
//

import Foundation

class PowerupMapping {
    static func getPowerupFor(color: PeggleColor) -> Powerup? {
        switch color {
        case .blue:
            return KaBoom()
        case .purple:
            return SpookyBall()
        case .gray:
            return ShapeShift()
        case .yellow:
            return Flash()
        case .pink:
            return RainFire()
        default:
            return nil
        }
    }
}
