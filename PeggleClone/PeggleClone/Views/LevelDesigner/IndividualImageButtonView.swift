//
//  IndividualImageButtonView.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/2/22.
//

import SwiftUI

struct IndividualImageButtonView: View {
    private static let imageButtonSize = 70.0
    private static let selectedOpacity = 1.0
    private static let notSelectedOpacity = 0.3

    @ObservedObject var designerViewModel: DesignerViewModel
    @ObservedObject var actionsViewModel: DesignerActionsViewModel

    let image: String
    let action: PeggleAction
    let actionType: PeggleAction.Type

    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(width: IndividualImageButtonView.imageButtonSize,
                   height: IndividualImageButtonView.imageButtonSize)
            .onTapGesture {
                SoundManager.shared.playSound(sound: .click)
                withAnimation(.easeInOut(duration: 0.2)) {
                    actionsViewModel.setAction(to: action)
                }
            }
            .opacity(
                type(of: actionsViewModel.currentAction) == actionType
                ? IndividualImageButtonView.selectedOpacity
                : IndividualImageButtonView.notSelectedOpacity
            )
    }
}
