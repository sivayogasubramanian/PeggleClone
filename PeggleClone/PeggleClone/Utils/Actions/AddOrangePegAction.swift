//
//  AddOrangePegAction.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 19/2/22.
//

import Foundation

class AddOrangePegAction: PeggleAction {
    func getPeggleType() -> PeggleType? {
        .peg
    }

    func getColor() -> PeggleColor? {
        .orange
    }

    func getDescription() -> String? {
        "You need to hit all of the orange pegs to win."
    }
}
