//
//  AddPurplePegAction.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/2/22.
//

import Foundation

class AddPurplePegAction: PeggleAction {
    func getPeggleType() -> PeggleType? {
        .peg
    }

    func getColor() -> PeggleColor? {
        .purple
    }

    func getDescription() -> String? {
        "Spooky-Ball: When the ball exits, it invokes its ghostly sprit to reappear at the top."
    }
}
