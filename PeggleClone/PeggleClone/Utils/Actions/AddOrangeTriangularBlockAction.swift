//
//  AddOrangeTriangularBlockAction.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 21/2/22.
//

class AddOrangeTriangularBlockAction: PeggleAction {
    func getPeggleType() -> PeggleType? {
        .block
    }

    func getColor() -> PeggleColor? {
        .orange
    }

    func getDescription() -> String? {
        "A regular orange triangular obstacle."
    }
}
