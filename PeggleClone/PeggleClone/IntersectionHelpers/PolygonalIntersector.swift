//
//  PolygonIntersector.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//

import CoreGraphics

protocol PolygonalIntersector {
    var vertices: [CGVector] { get }
    var edges: [Line] { get }
}
