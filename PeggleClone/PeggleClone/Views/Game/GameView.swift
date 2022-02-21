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
        NavigationView {
            ZStack(alignment: .top) {
                GeometryReader { _ in
                    Image(Constants.backgroundImage)
                        .resizable()
                        .frame(width: gameViewModel.boardWidth, height: gameViewModel.boardHeight)
                        .overlay {
                            overlayPegViews()
                        }
                        .overlay {
                            if let ball = gameViewModel.ball {
                                overlayBallView(ball)
                            }
                        }
                        .gesture(dragGestureForShoot)
                }

                cannonView
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: { backButtonView })
            }
        }
        .onAppear {
            gameViewModel.startSimulation()
        }
    }

    private var cannonView: some View {
        Image(Utils.cannonImageFileName(isCannonLoaded: gameViewModel.isCannonLoaded))
            .resizable()
            .frame(width: 100, height: 100, alignment: .center)
            .rotationEffect(rotateState)
            .offset(y: -7)
    }

    private var backButtonView: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
        })
    }

    private func overlayPegViews() -> some View {
        ForEach(gameViewModel.pegs) { peg in
            makePegView(peg)
        }.animation(.easeOut(duration: 0.5), value: gameViewModel.pegs)
    }

    private func makePegView(_ peg: PegGameObject) -> some View {
        Image(Utils.pegColorToImagePegFileName(color: peg.color, isHit: peg.isHit))
            .resizable()
            .frame(width: peg.diameter, height: peg.diameter, alignment: .center)
            .position(x: peg.physicsBody.position.dx, y: peg.physicsBody.position.dy)
    }

    private func overlayBallView(_ ball: BallGameObject) -> some View {
        Image("ball")
            .resizable()
            .frame(width: ball.diameter, height: ball.diameter)
            .position(x: ball.physicsBody.position.dx, y: ball.physicsBody.position.dy)
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
