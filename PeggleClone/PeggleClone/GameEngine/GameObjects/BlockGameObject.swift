//
//  BlockGameObject.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//

import Foundation
import CoreGraphics

class BlockGameObject {
    private static let pegGameObjectType = GameObjectType.block

    private(set) var physicsBody: PhysicsBody
    private(set) var color: PeggleColor
    private(set) var width: Double
    private(set) var height: Double
    private(set) var rotation: Double
    var isHit: Bool {
        false
    }
    var shouldBeRemoved: Bool {
        physicsBody.hitCount > PhysicsConstants.physicsBodyMaxHitCount
    }

    init(fromBlock block: TriangularBlock) {
        width = block.width
        height = block.height
        color = block.color
        rotation = block.rotation

        if block.springiness == 0 {
            physicsBody = StaticTriangularPhysicsBody(
                gameObjectType: BlockGameObject.pegGameObjectType,
                position: block.center,
                width: width,
                height: height,
                rotation: rotation
            )
        } else {
            physicsBody = SHMTriangularPhysicsBody(
                gameObjectType: BlockGameObject.pegGameObjectType,
                position: block.center,
                width: width,
                height: height,
                rotation: rotation,
                springiness: block.springiness
            )
        }
    }
}

extension BlockGameObject: Equatable, Identifiable {
    static func == (lhs: BlockGameObject, rhs: BlockGameObject) -> Bool {
        lhs === rhs
    }
}
