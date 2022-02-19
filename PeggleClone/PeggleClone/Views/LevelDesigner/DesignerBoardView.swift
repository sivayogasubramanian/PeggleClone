//
//  DesignerBoardView.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 22/1/22.
//

import SwiftUI

struct DesignerBoardView: View {
    @ObservedObject var designerViewModel: DesignerViewModel
    @ObservedObject var actionsViewModel: DesignerActionsViewModel

    @GestureState private var isDetectingLongPress = false

    var body: some View {
        GeometryReader { geometry in
            Image(Constants.backgroundImageFileName)
                .resizable()
                .scaledToFill()
                .gesture(
                    DragGesture(minimumDistance: 0).onEnded({ value in
                        withAnimation(.easeIn(duration: 0.1)) {
                            designerViewModel.addPeg(
                                at: value.location,
                                color: actionsViewModel.getPegColor()
                            )
                        }
                    })
                ).overlay {
                    overlayPegViews()
                }
                .onAppear(perform: {
                    designerViewModel.setBoardSize(to: geometry.size)
                })
        }
    }

    private func overlayPegViews() -> some View {
        ForEach(designerViewModel.board.pegs) { peg in
            makePegView(peg)
        }
    }

    private func makePegView(_ peg: Peg) -> some View {
        Image(Utils.pegColorToImageFileName(color: peg.color))
            .resizable()
            .frame(width: Peg.diameter, height: Peg.diameter, alignment: .center)
            .position(x: peg.center.x, y: peg.center.y)
            .onTapGesture {
                if type(of: actionsViewModel.currentAction) == DeletePegAction.self {
                    withAnimation(.easeOut(duration: 0.1)) {
                        designerViewModel.deletePeg(peg: peg)
                    }
                }
            }
            .onLongPressGesture(minimumDuration: 0.3, maximumDistance: 0, perform: {
                withAnimation(.easeOut(duration: 0.05)) {
                    designerViewModel.deletePeg(peg: peg)
                }
            })
            .gesture(DragGesture().onChanged({ value in
                withAnimation(.interactiveSpring(response: 0.4)) {
                    designerViewModel.movePeg(peg: peg, to: value.location)
                }
            }))
    }
}
