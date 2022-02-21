//
//  PolygonIntersector.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//

import Foundation
import CoreGraphics

protocol PolygonIntersector {
    var vertices: [CGVector] { get }
    var edges: [Line] { get }
}
