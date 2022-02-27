//
//  AddPurpleTriangularBlockAction.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/2/22.
//

class AddPurpleTriangularBlockAction: PeggleAction {
    func getPeggleType() -> PeggleType? {
        .block
    }

    func getColor() -> PeggleColor? {
        .purple
    }

    func getDescription() -> String? {
        "A regular purple triangular obstacle."
    }
}
