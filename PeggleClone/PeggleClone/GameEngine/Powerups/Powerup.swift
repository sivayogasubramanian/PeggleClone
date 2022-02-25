//
//  Powerup.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/2/22.
//

import Foundation

protocol Powerup {
    func applyPowerup(hitPeg: PegGameObject, gameEngine: PeggleGameEngine)
}
