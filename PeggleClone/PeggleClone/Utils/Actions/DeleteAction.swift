//
//  DeletePegAction.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 19/2/22.
//

import Foundation

class DeleteAction: PeggleAction {
    func getPeggleType() -> PeggleType? {
        nil
    }

    func getColor() -> PeggleColor? {
        nil
    }

    func getDescription() -> String? {
        "Deletes the tapped object from the designer."
    }
}
