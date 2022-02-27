//
//  BucketGameObject.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/2/22.
//

import CoreGraphics

class BucketGameObject {
    private static let gameObjectType = GameObjectType.bucket

    private(set) var physicsBody: PhysicsBody
    private(set) var width = Constants.bucketWidth
    private(set) var height = Constants.bucketHeight
    private(set) var rotation = Double.zero
    var isHit: Bool {
        physicsBody.hitCount != 0
    }

    init(position: CGVector) {
        physicsBody = OscillatingRectangularPhysicsBody(
            gameObjectType: BucketGameObject.gameObjectType,
            position: position,
            width: width,
            height: height,
            rotation: rotation
        )
    }
}
