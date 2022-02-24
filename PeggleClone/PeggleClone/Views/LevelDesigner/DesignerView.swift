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
        ZStack(alignment: .top) {
            boardView

            VStack {
                ImageButtonView(
                    designerViewModel: designerViewModel,
                    actionsViewModel: actionsViewModel
                )

                ActionButtonView(
                    boardView: boardView,
                    designerViewModel: designerViewModel,
                    actionsViewModel: actionsViewModel
                )
            }
            .background(Color.white)
        }
        .statusBar(hidden: true)
        .ignoresSafeArea(.keyboard)
        .edgesIgnoringSafeArea([.top, .bottom])
    }

    private var boardView: DesignerBoardView {
        DesignerBoardView(designerViewModel: designerViewModel, actionsViewModel: actionsViewModel)
    }
}
