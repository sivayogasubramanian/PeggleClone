//
//  PhysicsBody.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 4/2/22.
//

import Foundation
import CoreGraphics

class PhysicsBody {
    private(set) var gameObjectType: GameObjectType
    private(set) var position: CGVector
    private(set) var mass = Double.infinity
    private(set) var velocity = CGVector.zero
    private(set) var force = CGVector.zero
    private(set) var hitCount = 0
    var isMovable: Bool {
        mass != .infinity && mass != .zero
    }

    init(gameObjectType: GameObjectType, position: CGVector) {
        self.gameObjectType = gameObjectType
        self.position = position
    }

    init(gameObjectType: GameObjectType, position: CGVector, mass: Double) {
        self.gameObjectType = gameObjectType
        self.position = position
        self.mass = mass
    }

    func incrementHitCount(by count: Int = 1) {
        hitCount += count
    }

    func setVelocity(to velocity: CGVector) {
        guard isMovable else {
            return
        }
        self.velocity = velocity
    }

    func setForce(to force: CGVector) {
        guard isMovable else {
            return
        }
        self.force = force
    }

    func setPosition(to position: CGVector) {
        guard isMovable else {
            return
        }
        self.position = position
    }

    func updatePhysicsBody(dt deltaTime: TimeInterval) {
        guard isMovable else {
            return
        }
        let acceleration = force * (1 / mass)
        velocity += acceleration
        position += velocity * deltaTime
    }

    func resetHitCount() {
        hitCount = 0
    }
}
