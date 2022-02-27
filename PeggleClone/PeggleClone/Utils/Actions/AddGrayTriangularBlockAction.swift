//
//  AddGrayTriangularBlockAction.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/2/22.
//

class AddGrayTriangularBlockAction: PeggleAction {
    func getPeggleType() -> PeggleType? {
        .block
    }

    func getColor() -> PeggleColor? {
        .gray
    }

    func getDescription() -> String? {
        "A regular gray triangular obstacle."
    }
}
