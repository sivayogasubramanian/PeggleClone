//
//  Constants.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 22/1/22.
//

struct Constants {
    // Core-data
    static let coreDataContainerName = "PeggleCloneData"

    // Images
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
    static let grayPegImage = "peg-grey"
    static let glowingGrayPegImage = "peg-grey-glow"
    static let grayTriangularBlockImage = "peg-grey-triangle"
    static let glowingGrayTriangularBlockImage = "peg-grey-glow-triangle"
    static let yellowPegImage = "peg-yellow"
    static let glowingYellowPegImage = "peg-yellow-glow"
    static let yellowTriangularBlockImage = "peg-yellow-triangle"
    static let glowingYellowTriangularBlockImage = "peg-yellow-glow-triangle"

    // Numerics
    static let ballRadius = 20.0
    static let ballMinRadius = ballRadius / 2
    static let ballMaxRadius = ballRadius * 2
    static let pegRadius = 25.0
    static let blockWidth = 50.0
    static let blockHeight = 50.0
    static let bucketWidth = 150.0
    static let bucketHeight = 100.0
    static let bucketYCoordinateOffset = 10.0
    static let letterBoxYOffset = 170.0
    static let yCoordinatePadding = pegRadius * 4

    // Letterboxing
    static let xRatio = 7
    static let yRatio = 10
}
