//
//  Line.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 20/2/22.
//

import Foundation
import CoreGraphics

struct Line {
    let start: CGVector
    let end: CGVector

    private var isVertical = false
    private var isHorizontal = false

    init(start: CGVector, end: CGVector) {
        self.start = start
        self.end = end

        if start.dx == end.dx {
            isVertical = true
        }

        if start.dy == end.dy {
            isHorizontal = true
        }
    }

    func distanceToLine(from point: CGVector) -> Double {
        if isVertical {
            return abs(point.dx - start.dx)
        } else if isHorizontal {
            return abs(point.dy - start.dy)
        }

        let gradient = (end.dy - start.dy) / (end.dx - start.dx)
        let yIntercept = start.dy - gradient * start.dx

        return abs(gradient * point.dx - point.dy + yIntercept) / sqrt(gradient * gradient + 1)
    }
}
