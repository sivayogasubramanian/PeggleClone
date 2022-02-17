//
//  Utils.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 22/1/22.
//

struct Utils {
    static func deg2rad(_ number: Double) -> Double {
       number * .pi / 180
    }

    static func pegColorToImageFileName(color: PegColor) -> String {
        switch color {
        case .blue:
            return Constants.bluePegImageFileName
        case .orange:
            return Constants.orangePegImageFileName
        }
    }

    static func pegColorToImageFileName(color: PegColor, isHit: Bool) -> String {
        switch color {
        case .blue:
            return isHit ? Constants.glowingBluePegImageFileName : Constants.bluePegImageFileName
        case .orange:
            return isHit ? Constants.glowingOrangePegImageFileName : Constants.orangePegImageFileName
        }
    }

    static func cannonImageFileName(isCannonLoaded loadStatus: Bool) -> String {
        loadStatus ? Constants.cannontLoadedImageFileName : Constants.cannontUnloadedImageFileName
    }
}
