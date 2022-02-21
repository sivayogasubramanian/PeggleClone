//
//  DesignerActionsViewModel.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 22/1/22.
//

import Foundation

class DesignerActionsViewModel: ObservableObject {
    @Published private(set) var currentAction: PeggleAction = AddBluePegAction()

    func setAction(to action: PeggleAction) {
        currentAction = action
    }

    func getPeggleType() -> PeggleType? {
        currentAction.getPeggleType()
    }

    func getColor() -> PeggleColor? {
        currentAction.getColor()
    }
}
