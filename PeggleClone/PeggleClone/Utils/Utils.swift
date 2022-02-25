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

    static func pegColorToImagePegFileName(color: PeggleColor, isHit: Bool = false) -> String {
        switch color {
        case .blue:
            return isHit ? Constants.glowingBluePegImage : Constants.bluePegImage
        case .orange:
            return isHit ? Constants.glowingOrangePegImage : Constants.orangePegImage
        case .purple:
            return isHit ? Constants.glowingPurplePegImage : Constants.purplePegImage
        }
    }

    static func pegColorToImageBlockFileName(color: PeggleColor, isHit: Bool = false) -> String {
        switch color {
        case .blue:
            return isHit ? Constants.glowingBlueTriangularBlockImage : Constants.blueTriangularBlockImage
        case .orange:
            return isHit ? Constants.glowingOrangeTriangularBlockImage : Constants.orangeTriangularBlockImage
        case .purple:
            return isHit ? Constants.glowingPurpleTriangularBlockImage : Constants.purpleTriangularBlockImage
        }
    }

    static func cannonImageFileName(isCannonLoaded loadStatus: Bool) -> String {
        loadStatus ? Constants.cannontLoadedImage : Constants.cannontUnloadedImage
    }
}
