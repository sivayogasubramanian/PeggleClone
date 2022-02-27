//
//  Line.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 20/2/22.
//

import CoreGraphics

struct Line {
    let start: CGVector
    let end: CGVector
    private var isVertical = false
    private var isHorizontal = false
    var direction: CGVector {
        end - start
    }

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

    func closestPointOnLine(to point: CGVector) -> CGVector {
        if isVertical {
            return CGVector(dx: start.dx, dy: point.dy)
        } else if isHorizontal {
            return CGVector(dx: point.dx, dy: start.dy)
        }

        let gradient = (end.dy - start.dy) / (end.dx - start.dx)
        let yIntercept = start.dy - gradient * start.dx
        let normalGradient = -1 / gradient
        let normalYIntercept = point.dy - normalGradient * point.dx

        let xCoordinate = (normalYIntercept - yIntercept) / (gradient - normalGradient)
        let yCoordinate = gradient * xCoordinate + yIntercept

        return CGVector(dx: xCoordinate, dy: yCoordinate)
    }

    func shortestDistance(from point: CGVector) -> Double {
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
