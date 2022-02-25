//
//  Constants.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 22/1/22.
//

struct Constants {
    static let coreDataContainerName = "PeggleCloneData"

    static let mainBackgroundImage = "main-background"
    static let backButtonImage = "back-button"
    static let backgroundImage = "background"
    static let ballImage = "ball"
    static let bucketImage = "bucket"
    static let bluePegImage = "peg-blue"
    static let blueTriangularBlockImage = "peg-blue-triangle"
    static let purpleTriangularBlockImage = "peg-purple-triangle"
    static let cannontLoadedImage = "cannon-loaded"
    static let cannontUnloadedImage = "cannon-unloaded"
    static let deleteButtonImage = "delete"
    static let purplePegImage = "peg-purple"
    static let glowingBluePegImage = "peg-blue-glow"
    static let glowingBlueTriangularBlockImage = "peg-blue-glow-triangle"
    static let glowingPurplePegImage = "peg-purple-glow"
    static let glowingPurpleTriangularBlockImage = "peg-purple-glow-triangle"
    static let glowingOrangePegImage = "peg-orange-glow"
    static let glowingOrangeTriangularBlockImage = "peg-orange-glow-triangle"
    static let orangePegImage = "peg-orange"
    static let orangeTriangularBlockImage = "peg-orange-triangle"

    static let ballRadius = 20.0
    static let pegRadius = 25.0
    static let blockWidth = 50.0
    static let blockHeight = 50.0
    static let bucketWidth = 150.0
    static let bucketHeight = 100.0
    static let bucketYCoordinateOffset = 10.0
    static let letterBoxYOffset = 170.0
    static let yCoordinatePadding = pegRadius * 4

    static let xRatio = 7
    static let yRatio = 10

    static let powerups: [Powerup] = [KaBoom(), SpookyBall()]
}
