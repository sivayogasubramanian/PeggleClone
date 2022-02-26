//
//  Utils.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 22/1/22.
//

import CoreGraphics

struct Utils {
    static func deg2rad(_ number: Double) -> Double {
       number * .pi / 180
    }

    static func pegColorToImagePegFileName(color: PeggleColor, isLit: Bool = false) -> String {
        switch color {
        case .blue:
            return isLit ? Constants.glowingBluePegImage : Constants.bluePegImage
        case .orange:
            return isLit ? Constants.glowingOrangePegImage : Constants.orangePegImage
        case .purple:
            return isLit ? Constants.glowingPurplePegImage : Constants.purplePegImage
        case .gray:
            return isLit ? Constants.glowingGrayPegImage : Constants.grayPegImage
        case .yellow:
            return isLit ? Constants.glowingYellowPegImage : Constants.yellowPegImage
        case .pink:
            return isLit ? Constants.glowingPinkPegImage : Constants.pinkPegImage
        }
    }

    static func pegColorToImageBlockFileName(color: PeggleColor, isLit: Bool = false) -> String {
        switch color {
        case .blue:
            return isLit ? Constants.glowingBlueTriangularBlockImage : Constants.blueTriangularBlockImage
        case .orange:
            return isLit ? Constants.glowingOrangeTriangularBlockImage : Constants.orangeTriangularBlockImage
        case .purple:
            return isLit ? Constants.glowingPurpleTriangularBlockImage : Constants.purpleTriangularBlockImage
        case .gray:
            return isLit ? Constants.glowingGrayTriangularBlockImage : Constants.grayTriangularBlockImage
        case .yellow:
            return isLit ? Constants.glowingYellowTriangularBlockImage : Constants.yellowTriangularBlockImage
        case .pink:
            return isLit ? Constants.glowingPinkTriangularBlockImage : Constants.pinkTriangularBlockImage
        }
    }

    static func cannonImageFileName(isCannonLoaded loadStatus: Bool) -> String {
        loadStatus ? Constants.cannontLoadedImage : Constants.cannontUnloadedImage
    }

    static func getScoreWhenPegHit(pegs: [PegGameObject]) -> Int {
        let orangeBalls = pegs.filter({ $0.color == .orange })
        let orangeBallsHit = orangeBalls.filter({ $0.isLit })
        let orangeBallsLeft = orangeBalls.count - orangeBallsHit.count
        var multiplier = 1
        if orangeBallsLeft == 0 {
            multiplier = 100
        } else if orangeBallsLeft <= 3 {
            multiplier = 10
        } else if orangeBallsLeft <= 7 {
            multiplier = 5
        } else if orangeBallsLeft <= 10 {
            multiplier = 3
        } else if orangeBallsLeft <= 15 {
            multiplier = 2
        }

        var score = 0
        for peg in pegs where peg.isLit {
            score += getScore(pegColor: peg.color)
        }
        return score * multiplier
    }

    private static func getScore(pegColor: PeggleColor) -> Int {
        switch pegColor {
        case .pink:
            return 1
        case .blue:
            return 10
        case .gray:
            return 50
        case .orange:
            return 100
        case .purple:
            return 500
        case .yellow:
            return 1000
        }
    }
}
