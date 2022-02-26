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
        }
    }

    static func cannonImageFileName(isCannonLoaded loadStatus: Bool) -> String {
        loadStatus ? Constants.cannontLoadedImage : Constants.cannontUnloadedImage
    }
}
