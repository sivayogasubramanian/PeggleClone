//
//  AddPinkTriangularBlockAction.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/2/22.
//

import Foundation

class AddPinkTriangularBlockAction: PeggleAction {
    func getPeggleType() -> PeggleType? {
        .block
    }

    func getColor() -> PeggleColor? {
        .pink
    }

    func getDescription() -> String? {
        "A regular gray pink obstacle."
    }
}
