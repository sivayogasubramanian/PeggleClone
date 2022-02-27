//
//  AddBlueTriangularBlockAction.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 20/2/22.
//

class AddBlueTriangularBlockAction: PeggleAction {
    func getPeggleType() -> PeggleType? {
        .block
    }

    func getColor() -> PeggleColor? {
        .blue
    }

    func getDescription() -> String? {
        "A regular blue triangular obstacle."
    }
}
