//
//  DesignerActionsViewModel.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 22/1/22.
//

import Foundation

class DesignerActionsViewModel: ObservableObject {
    enum Actions {
        case addBluePeg, addOrangePeg, deletePeg
    }

    @Published private(set) var currentAction = Actions.addBluePeg

    func setAction(to action: Actions) {
        currentAction = action
    }

    func getPegColor() -> PegColor? {
        switch currentAction {
        case .addBluePeg:
            return .blue
        case .addOrangePeg:
            return .orange
        case .deletePeg:
            return nil
        }
    }
}
