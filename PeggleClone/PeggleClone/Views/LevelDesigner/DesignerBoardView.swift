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
            .animation(.default, value: peg.radius)
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
            .animation(.default, value: block.width)
            .animation(.default, value: block.height)
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
            .overlay {
                if designerViewModel.showSpringinessCircle && designerViewModel.selectedBlock === block {
                    overlaySpringinessCircle(block: block)
                }
            }
    }

    private func overlaySpringinessCircle(block: TriangularBlock) -> some View {
        Circle()
            .stroke(lineWidth: 1)
            .fill(.gray)
            .opacity(0.3)
            .frame(width: max(block.springiness, 125), height: max(block.springiness, 125))
            .position(x: block.center.dx, y: block.center.dy)
            .animation(.default, value: block.springiness)
            .overlay(content: { makeMiniResizingCircles(block) })
    }

    private func makeMiniResizingCircles(_ block: TriangularBlock) -> some View {
        // 4 corners of the big circle
        let centers = [
            CGVector(dx: block.center.dx, dy: block.center.dy - block.springiness / 2),
            CGVector(dx: block.center.dx, dy: block.center.dy + block.springiness / 2),
            CGVector(dx: block.center.dx + block.springiness / 2, dy: block.center.dy),
            CGVector(dx: block.center.dx - block.springiness / 2, dy: block.center.dy)
        ]

        return ForEach(0..<centers.count, id: \.self) { index in
            let center = centers[index]

            Circle().fill(.gray).opacity(0.2).frame(width: 30, height: 30)
                .position(
                    x: center.dx, y: center.dy
                ).gesture(DragGesture()
                            .onChanged({ value in dragHandler(block: block, value.location) })
                ).animation(.default, value: block.springiness)
        }
    }
}

extension DesignerBoardView {
    private func dragHandler(block: TriangularBlock, _ location: CGPoint) {
        designerViewModel.setSpringiness(for: block, location: location)
    }
}
