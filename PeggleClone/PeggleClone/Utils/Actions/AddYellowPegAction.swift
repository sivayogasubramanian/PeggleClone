//
//  AddYellowPegAction.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/2/22.
//

class AddYellowPegAction: PeggleAction {
    func getPeggleType() -> PeggleType? {
        .peg
    }

    func getColor() -> PeggleColor? {
        .yellow
    }

    func getDescription() -> String? {
        "Flash: The game ball has a chance to have its speed doubled when this peg is hit for the first time."
    }
}
