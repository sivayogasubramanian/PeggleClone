//
//  AddPinkPegAction.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/2/22.
//

class AddPinkPegAction: PeggleAction {
    func getPeggleType() -> PeggleType? {
        .peg
    }

    func getColor() -> PeggleColor? {
        .pink
    }

    func getDescription() -> String? {
        "Rain Fire: Spawns 4 new balls at the top that help clear pegs until the main ball is active."
    }
}
