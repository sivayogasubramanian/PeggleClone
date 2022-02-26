//
//  PowerupMapping.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/2/22.
//

import Foundation

class PowerupMapping {
    static func getPowerupFor(color: PeggleColor) -> Powerup? {
        if color == .blue {
            return KaBoom()
        } else if color == .purple {
            return SpookyBall()
        } else if color == .gray {
            return ShapeShift()
        } else if color == .yellow {
            return Flash()
        } else if color == .pink {
            return RainFire()
        }

        return nil
    }
}
