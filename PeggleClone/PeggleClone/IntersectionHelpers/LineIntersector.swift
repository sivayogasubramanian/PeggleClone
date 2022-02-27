//
//  LineIntersector.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//

import CoreGraphics

protocol LineIntersector {
    var line: Line { get }
    var start: CGVector { get }
    var end: CGVector { get }

    func closestPointOnLine(to point: CGVector) -> CGVector
    func shortestDistance(from point: CGVector) -> Double
}
