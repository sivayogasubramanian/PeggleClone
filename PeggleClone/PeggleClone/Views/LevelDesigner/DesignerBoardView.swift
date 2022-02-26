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
                    DragGesture(minimumDistance: 20).onChanged({ value in
                        designerViewModel.setBoardOffset(to: value.translation.height / 15)
                    })
                )
                .gesture(
                    DragGesture(minimumDistance: 0).onEnded({ value in
                        withAnimation(.easeIn(duration: 0.1)) {
                            boardTapHandler(value.location)
                        }
                    })
                )
                .overlay {
                    overlayPegViews()
                    overlayBlockViews()
                }
                .onAppear(perform: {
                    designerViewModel.setBoardSize(to: geometry.size)
                })
                .clipped()
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
        let image = peg === designerViewModel.selectedPeg
            ? Utils.pegColorToImagePegFileName(color: peg.color, isLit: true)
            : Utils.pegColorToImagePegFileName(color: peg.color)
        return Image(image)
            .resizable()
            .frame(width: peg.diameter, height: peg.diameter)
            .rotationEffect(Angle(degrees: peg.rotation))
            .animation(.default, value: peg.rotation)
            .animation(.default, value: peg.radius)
            .animation(.spring(), value: designerViewModel.board.boardHeightOffset)
            .position(x: peg.center.dx, y: peg.center.dy)
            .offset(x: 0, y: designerViewModel.board.boardHeightOffset)
            .onTapGesture {
                SoundManager.shared.playSound(sound: .click2)
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
        let image = block === designerViewModel.selectedBlock
            ? Utils.pegColorToImageBlockFileName(color: block.color, isLit: true)
            : Utils.pegColorToImageBlockFileName(color: block.color)
        return Image(image)
            .resizable()
            .frame(width: block.width, height: block.height)
            .rotationEffect(Angle(degrees: block.rotation))
            .position(x: block.center.dx, y: block.center.dy)
            .offset(x: 0, y: designerViewModel.board.boardHeightOffset)
            .animation(.default, value: block.rotation)
            .animation(.default, value: block.width)
            .animation(.default, value: block.height)
            .animation(.spring(), value: designerViewModel.board.boardHeightOffset)
            .onTapGesture {
                SoundManager.shared.playSound(sound: .click2)
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
            .offset(x: 0, y: designerViewModel.board.boardHeightOffset)
            .animation(.default, value: block.springiness)
            .animation(.spring(), value: designerViewModel.board.boardHeightOffset)
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
                )
                .offset(x: 0, y: designerViewModel.board.boardHeightOffset)
                .gesture(DragGesture().onChanged({ value in
                    springinessDragHandler(block: block, value.location) })
                )
                .animation(.default, value: block.springiness)
                .animation(.default, value: designerViewModel.board.boardHeightOffset)
        }
    }
}

extension DesignerBoardView {
    private func boardTapHandler(_ location: CGPoint) {
        if actionsViewModel.getPeggleType() == .peg {
            if designerViewModel.addPeg(
                at: location,
                color: actionsViewModel.getColor()
            ) {
                SoundManager.shared.playSound(sound: .click2)
            }
        }

        if actionsViewModel.getPeggleType() == .block {
            if designerViewModel.addBlock(
                at: location,
                color: actionsViewModel.getColor()
            ) {
                SoundManager.shared.playSound(sound: .click2)

            }
        }
    }

    private func springinessDragHandler(block: TriangularBlock, _ location: CGPoint) {
        designerViewModel.setSpringiness(for: block, location: location)
    }
}
