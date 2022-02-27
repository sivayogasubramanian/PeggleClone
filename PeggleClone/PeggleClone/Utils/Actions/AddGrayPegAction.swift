//
//  AddGrayPegAction.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/2/22.
//

class AddGrayPegAction: PeggleAction {
    func getPeggleType() -> PeggleType? {
        .peg
    }

    func getColor() -> PeggleColor? {
        .gray
    }

    func getDescription() -> String? {
        "Shape-Shift: The game ball has a chance to change size when this peg is hit for the first time."
    }
}
