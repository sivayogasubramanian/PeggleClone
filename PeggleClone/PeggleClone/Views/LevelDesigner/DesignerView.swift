//
//  DesignerView.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 19/1/22.
//

import SwiftUI

struct DesignerView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var designerViewModel = DesignerViewModel()
    @StateObject private var actionsViewModel = DesignerActionsViewModel()

    @State private var isBackTapped = false

    var body: some View {
        ZStack(alignment: .top) {
            boardView
                .overlay(alignment: .bottomTrailing) {
                    designerObjectCounterView
                        .padding(.bottom, 30).padding(.trailing, 20)
                }
                .overlay(alignment: .bottomLeading) {
                    boardOffsetView
                        .padding(.bottom, 35).padding(.leading, 20)
                }

            VStack(spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    backButtonView.padding(.top, 10).padding(.leading, 15)

                    ActionButtonView(
                        boardView: boardView,
                        designerViewModel: designerViewModel,
                        actionsViewModel: actionsViewModel
                    )
                }

                ImageButtonView(
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

    private var designerObjectCounterView: some View {
        DesignerObjectCounterView(
            bluePeg: designerViewModel.numberOfBluePegsAdded,
            orangePeg: designerViewModel.numberOfOrangePegsAdded,
            purplePeg: designerViewModel.numberOfPurplePegsAdded,
            grayPeg: designerViewModel.numberOfGrayPegsAdded,
            yellowPeg: designerViewModel.numberOfYellowPegsAdded,
            pinkPeg: designerViewModel.numberOfPinkPegsAdded,
            blueBlock: designerViewModel.numberOfBlueBlocksAdded,
            orangeBlock: designerViewModel.numberOfOrangeBlocksAdded,
            purpleBlock: designerViewModel.numberOfPurpleBlocksAdded,
            grayBlock: designerViewModel.numberOfGrayBlocksAdded,
            yellowBlock: designerViewModel.numberOfYellowBlocksAdded,
            pinkBlock: designerViewModel.numberOfPinkBlocksAdded
        )
    }

    private var boardOffsetView: some View {
        let offset = Int(designerViewModel.board.boardHeightOffset.rounded())

        return HStack {
            Text("Offset:")
                .font(.title2)

            Text(String(offset == 0 ? 0 : -offset))
                .bold()
                .font(.title2)
        }
    }

    private var backButtonView: some View {
        Button(action: {
            isBackTapped = true
        }, label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("BACK")
            }
        })
        .alert(
            "Please remember to save your progress. Any progress made will be lost if it is not saved.",
            isPresented: $isBackTapped,
            actions: {
                Button("Cancel", role: .cancel, action: {})
                Button("Ok", role: .destructive, action: { dismiss() })
            })
    }
}
