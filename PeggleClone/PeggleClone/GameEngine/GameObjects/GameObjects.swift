//
//  GameObjects.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 11/2/22.
//

class GameObjects {
    private static var ballCollidesWith = Set<GameObjectType>([.ball, .peg, .block, .bucket])
    private static var pegCollidesWith = Set<GameObjectType>([.ball])
    private static var lineCollidesWith = Set<GameObjectType>([.ball])
    private static var blockCollidesWith = Set<GameObjectType>([.ball])
    private static var bucketCollidesWith = Set<GameObjectType>([.ball])

    static func areCollidable(_ object1: GameObjectType, _ object2: GameObjectType) -> Bool {
        switch object1 {
        case .ball:
            return ballCollidesWith.contains(object2)
        case .line:
            return lineCollidesWith.contains(object2)
        case .peg:
            return pegCollidesWith.contains(object2)
        case .block:
            return blockCollidesWith.contains(object2)
        case .bucket:
            return bucketCollidesWith.contains(object2)
        }
    }
}

enum GameObjectType {
    case ball, line, peg, block, bucket
}
