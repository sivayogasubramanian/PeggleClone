//
//  Peg.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 20/1/22.
//

import CoreGraphics
import Foundation

final class Peg: Identifiable {
    static let radius = CGFloat(25)
    static let diameter = radius * 2

    let uuid: UUID
    let color: PegColor
    private(set) var center: CGPoint

    convenience init(color: PegColor, center: CGPoint) {
        self.init(uuid: UUID(), color: color, center: center)
    }

    init(uuid: UUID, color: PegColor, center: CGPoint) {
        self.uuid = uuid
        self.color = color
        self.center = center
    }

    func changeCenter(to center: CGPoint) {
        self.center = center
    }
}

@objc public enum PegColor: Int16 {
    case blue = 0, orange = 1
}
