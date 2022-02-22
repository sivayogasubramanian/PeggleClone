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
            Image(Constants.backgroundImage)
                .resizable()
                .scaledToFill()
                .gesture(
                    DragGesture(minimumDistance: 0).onEnded({ value in
                        withAnimation(.easeIn(duration: 0.1)) {
                            designerViewModel.resetSelectedObjects()

                            if actionsViewModel.getPeggleType() == .peg {
                                designerViewModel.addPeg(
                                    at: value.location,
                                    color: actionsViewModel.getColor()
                                )
                            }

                            if actionsViewModel.getPeggleType() == .block {
                                designerViewModel.addBlock(
                                    at: value.location,
                                    color: actionsViewModel.getColor()
                                )
                            }
                        }
                    })
                ).overlay {
                    overlayPegViews()
                    overlayBlockViews()
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

    private func overlayBlockViews() -> some View {
        ForEach(designerViewModel.board.blocks) { block in
            makeBlockView(block)
        }
    }

    private func makePegView(_ peg: Peg) -> some View {
        Image(Utils.pegColorToImagePegFileName(color: peg.color))
            .resizable()
            .frame(width: peg.diameter, height: peg.diameter, alignment: .center)
            .rotationEffect(Angle(degrees: peg.rotation))
            .animation(.default, value: peg.rotation)
            .position(x: peg.center.dx, y: peg.center.dy)
            .onTapGesture {
                if type(of: actionsViewModel.currentAction) == DeleteAction.self {
                    withAnimation(.easeOut(duration: 0.1)) {
                        designerViewModel.deletePeg(peg: peg)
                    }
                } else {
                    designerViewModel.setSelectedPeg(peg)
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

    private func makeBlockView(_ block: TriangularBlock) -> some View {
        Image(Utils.pegColorToImageBlockFileName(color: block.color))
            .resizable()
            .frame(width: block.width, height: block.height, alignment: .center)
            .rotationEffect(Angle(degrees: block.rotation))
            .position(x: block.center.dx, y: block.center.dy)
            .animation(.default, value: block.rotation)
            .onTapGesture {
                if type(of: actionsViewModel.currentAction) == DeleteAction.self {
                    withAnimation(.easeOut(duration: 0.1)) {
                        designerViewModel.deleteBlock(block: block)
                    }
                } else {
                    designerViewModel.setSelectedBlock(block)
                }
            }
            .onLongPressGesture(minimumDuration: 0.3, maximumDistance: 0, perform: {
                withAnimation(.easeOut(duration: 0.05)) {
                    designerViewModel.deleteBlock(block: block)
                }
            })
            .gesture(DragGesture().onChanged({ value in
                withAnimation(.interactiveSpring(response: 0.4)) {
                    designerViewModel.moveBlock(block: block, to: value.location)
                }
            }))
    }
}
