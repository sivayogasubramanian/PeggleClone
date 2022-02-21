//
//  AddOrangeTriangularBlockAction.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//

import Foundation

class AddOrangeTriangularBlockAction: PeggleAction {
    func getPeggleType() -> PeggleType? {
        .block
    }

    func getColor() -> PeggleColor? {
        .orange
    }
}
