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
    var isHit: Bool {
        physicsBody.hitCount != 0
    }
    var shouldBeRemoved: Bool {
        physicsBody.hitCount > PhysicsConstants.physicsBodyMaxHitCount
    }

    init(fromBlock: TriangularBlock) {
        width = fromBlock.width
        height = fromBlock.height
        color = fromBlock.color
        physicsBody = PolygonalPhysicsBody(
            gameObjectType: BlockGameObject.pegGameObjectType,
            position: fromBlock.center,
            vertices: fromBlock.vertices,
            edges: fromBlock.edges
        )
    }
}

extension BlockGameObject: Equatable, Identifiable {
    static func == (lhs: BlockGameObject, rhs: BlockGameObject) -> Bool {
        lhs === rhs
    }
}
