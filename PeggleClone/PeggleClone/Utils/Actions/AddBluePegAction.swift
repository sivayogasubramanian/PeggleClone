//
//  AddBluePegAction.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 19/2/22.
//

import Foundation

class AddBluePegAction: PeggleAction {
    func getPeggleType() -> PeggleType? {
        .peg
    }

    func getColor() -> PeggleColor? {
        .blue
    }

    func getDescription() -> String? {
        "Ka-Boom: Sets of a chain explosion of blue pegs. Nearby pegs will be lit."
    }
}
