//
//  PolygonIntersector.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//

import Foundation
import CoreGraphics

protocol PolygonalIntersector {
    var vertices: [CGVector] { get }
    var edges: [Line] { get }
}
