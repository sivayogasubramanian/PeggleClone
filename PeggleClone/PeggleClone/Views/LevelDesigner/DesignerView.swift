//
//  DesignerView.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 19/1/22.
//

import SwiftUI

struct DesignerView: View {
    @StateObject private var designerViewModel = DesignerViewModel()
    @StateObject private var actionsViewModel = DesignerActionsViewModel()

    var body: some View {
        VStack {
            ActionButtonView(
                boardView: boardView,
                designerViewModel: designerViewModel,
                actionsViewModel: actionsViewModel
            ).padding(.top, 15)

            boardView

            ImageButtonView(actionsViewModel: actionsViewModel)
                .padding(.vertical, 15)
        }.ignoresSafeArea(.keyboard)
    }

    private var boardView: DesignerBoardView {
        DesignerBoardView(designerViewModel: designerViewModel, actionsViewModel: actionsViewModel)
    }
}
