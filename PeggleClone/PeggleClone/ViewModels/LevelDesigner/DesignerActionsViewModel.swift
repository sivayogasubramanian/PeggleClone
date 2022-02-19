//
//  DesignerActionsViewModel.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 22/1/22.
//

import Foundation

class DesignerActionsViewModel: ObservableObject {
    @Published private(set) var currentAction: PegAction = AddBluePegAction()

    func setAction(to action: PegAction) {
        currentAction = action
    }

    func getPegColor() -> PegColor? {
        currentAction.getPegColor()
    }
}
