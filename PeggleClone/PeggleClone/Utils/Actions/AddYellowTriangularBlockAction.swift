//
//  AddYellowTriangularBlockAction.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/2/22.
//

class AddYellowTriangularBlockAction: PeggleAction {
    func getPeggleType() -> PeggleType? {
        .block
    }

    func getColor() -> PeggleColor? {
        .yellow
    }

    func getDescription() -> String? {
        "A regular gray yellow obstacle."
    }
}
