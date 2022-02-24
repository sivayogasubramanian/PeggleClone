//
//  ContentView.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 3/2/22.
//

import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var gameViewModel: GameViewModel
    @State private var rotateState: Angle = .zero

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Image(Constants.backgroundImage)
                    .resizable()
                    .gesture(dragGestureForShoot)
            }

            if let ball = gameViewModel.ball {
                overlayBallView(ball)
            }
            overlayPegViews()
            overlayBlockViews()
            cannonView
            backButtonView
        }
        .onAppear {
            gameViewModel.startSimulation()
        }
        .statusBar(hidden: true)
        .edgesIgnoringSafeArea([.top, .bottom])
    }

    private var cannonView: some View {
        Image(Utils.cannonImageFileName(isCannonLoaded: gameViewModel.isCannonLoaded))
            .resizable()
            .frame(width: 100, height: 100)
            .rotationEffect(rotateState)
            .offset(y: -7)
    }

    private var backButtonView: some View {
        Image(Constants.backButtonImage)
            .resizable().opacity(0.3).scaledToFit()
            .frame(width: 50, height: 50)
            .position(x: 40, y: 50)
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
    }

    private func overlayPegViews() -> some View {
        ZStack {
            ForEach(gameViewModel.pegs) { peg in
                makePegView(peg).transition(.scale(scale: 1.1).combined(with: .opacity))
            }
        }.animation(.easeOut(duration: 0.5), value: gameViewModel.pegs)
    }

    private func makePegView(_ peg: PegGameObject) -> some View {
        Image(Utils.pegColorToImagePegFileName(color: peg.color, isHit: peg.isHit))
            .resizable()
            .frame(width: peg.diameter, height: peg.diameter)
            .rotationEffect(Angle(degrees: peg.rotation))
            .position(x: peg.physicsBody.position.dx, y: peg.physicsBody.position.dy)
            .offset(x: 0, y: gameViewModel.offset)
            .animation(.interactiveSpring(), value: gameViewModel.offset)
    }

    private func overlayBlockViews() -> some View {
        ZStack {
            ForEach(gameViewModel.blocks) { block in
                makeBlockView(block).transition(.scale(scale: 1.1).combined(with: .opacity))
            }
        }.animation(.easeOut(duration: 0.5), value: gameViewModel.blocks)
    }

    private func makeBlockView(_ block: BlockGameObject) -> some View {
        Image(Utils.pegColorToImageBlockFileName(color: block.color, isHit: block.isHit))
            .resizable()
            .frame(width: block.width, height: block.height)
            .rotationEffect(Angle(degrees: block.rotation))
            .position(x: block.physicsBody.position.dx, y: block.physicsBody.position.dy)
            .offset(x: 0, y: gameViewModel.offset)
            .animation(.interactiveSpring(), value: gameViewModel.offset)
    }

    private func overlayBallView(_ ball: BallGameObject) -> some View {
        Image("ball")
            .resizable()
            .frame(width: ball.diameter, height: ball.diameter)
            .position(x: ball.physicsBody.position.dx, y: ball.physicsBody.position.dy + gameViewModel.offset)
            .onChange(of: ball.physicsBody.position.dy) { newY in
                gameViewModel.setOffset(using: newY)
            }
            .animation(.interactiveSpring(), value: gameViewModel.offset)
    }

    private var dragGestureForShoot: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged({ value in
                let point = CGPoint(
                    x: value.location.x,
                    y: max(value.location.y, PhysicsConstants.initialBallLaunchYCoordinate)
                )
                rotateState = gameViewModel.getAngleForCanon(using: point)
            })
            .onEnded({ value in
                let point = CGPoint(
                    x: value.location.x,
                    y: max(value.location.y, PhysicsConstants.initialBallLaunchYCoordinate)
                )
                gameViewModel.shootBallTowards(point: point)
            })
    }
}
