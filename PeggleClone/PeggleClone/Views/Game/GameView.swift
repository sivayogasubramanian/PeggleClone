//
//  ContentView.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 3/2/22.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var gameViewModel: GameViewModel
    @State private var rotateState: Angle = .zero

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Image(Constants.backgroundImage)
                    .resizable()
                    .overlay(alignment: .topTrailing) {
                        gameObjectCounterView
                            .padding(.top, 15).padding(.trailing, 20)
                            .opacity(0.8)
                    }
                    .overlay(alignment: .topLeading) {
                        backButtonView.padding(.top, 15).padding(.leading, 20)
                    }
                    .overlay(alignment: .topLeading) {
                        scoreAndTimerView.padding(.top, 15).padding(.leading, 100)
                    }
            }

            if let ball = gameViewModel.ball {
                makeBallView(ball, isMainBall: true)
            }
            overlayPegViews()
            overlayBlockViews()
            overlayBucketView()
            overlayBallViews()
            cannonView
        }
        .gesture(dragGestureForShoot)
        .alert("Congratulations! You Won! Your final score was \(gameViewModel.score)!",
               isPresented: Binding(get: { gameViewModel.isGameWon }, set: { _, _ in }),
               actions: {
            Button("Okay", action: { dismiss() })
                .onAppear(perform: {
                    SoundManager.shared.playSound(sound: .win)
                    gameViewModel.stopSimulation()
                })
                .onDisappear(perform: { dismiss() })
        })
        .alert("Sorry! You lost. You will do better next time!",
               isPresented: Binding(get: { gameViewModel.isGameOver || gameViewModel.isTimeOver }, set: { _, _ in }),
               actions: {
            Button("Okay", action: { dismiss() })
                .onAppear(perform: {
                    SoundManager.shared.playSound(sound: .lose)
                    gameViewModel.stopSimulation()
                })
                .onDisappear(perform: { dismiss() })
        })
        .onAppear {
            gameViewModel.startSimulation()
            SoundManager.shared.stopSound(sound: .main)
            SoundManager.shared.playSound(sound: .game, isReducedVolume: true, isLooped: true)
        }
        .onDisappear(perform: {
            SoundManager.shared.stopSound(sound: .game)
            SoundManager.shared.playSound(sound: .main, isReducedVolume: true, isLooped: true)
        })
        .statusBar(hidden: true)
        .edgesIgnoringSafeArea([.top, .bottom])
    }

    private var gameObjectCounterView: some View {
        GameObjectCounterView(
            blue: gameViewModel.numberOfBluePegsLeft,
            orange: gameViewModel.numberOfOrangePegsLeft,
            purple: gameViewModel.numberOfPurplePegsLeft,
            gray: gameViewModel.numberOfGrayPegsLeft,
            yellow: gameViewModel.numberOfYellowPegsLeft,
            pink: gameViewModel.numberOfPinkPegsLeft,
            balls: gameViewModel.numberOfBallsLeft
        )
    }

    private var cannonView: some View {
        Image(Utils.cannonImageFileName(isCannonLoaded: gameViewModel.isCannonLoaded))
            .resizable()
            .frame(width: 100, height: 100)
            .rotationEffect(rotateState)
    }

    private var backButtonView: some View {
        Image(Constants.backButtonImage)
            .resizable().opacity(0.3).scaledToFit()
            .frame(width: 50, height: 50)
            .onTapGesture {
                dismiss()
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
        Image(Utils.pegColorToImagePegFileName(color: peg.color, isLit: peg.isLit))
            .resizable()
            .frame(width: peg.diameter, height: peg.diameter)
            .rotationEffect(Angle(degrees: peg.rotation))
            .position(x: peg.physicsBody.position.dx, y: peg.physicsBody.position.dy)
            .offset(x: 0, y: gameViewModel.offset)
            .animation(.interactiveSpring(), value: gameViewModel.offset)
            .onChange(of: peg.isLit, perform: { _ in SoundManager.shared.playSound(sound: .hitPeg) })
    }

    private func overlayBlockViews() -> some View {
        ZStack {
            ForEach(gameViewModel.blocks) { block in
                makeBlockView(block).transition(.scale(scale: 1.1).combined(with: .opacity))
            }
        }.animation(.easeOut(duration: 0.5), value: gameViewModel.blocks)
    }

    private func overlayBallViews() -> some View {
        ZStack {
            ForEach(gameViewModel.balls) { ball in
                makeBallView(ball).transition(.scale(scale: 1.1).combined(with: .opacity))
            }
        }.animation(.easeOut(duration: 0.5), value: gameViewModel.balls)
    }

    private func makeBlockView(_ block: BlockGameObject) -> some View {
        Image(Utils.pegColorToImageBlockFileName(color: block.color, isLit: block.isLit))
            .resizable()
            .frame(width: block.width, height: block.height)
            .rotationEffect(Angle(degrees: block.rotation))
            .position(x: block.physicsBody.position.dx, y: block.physicsBody.position.dy)
            .offset(x: 0, y: gameViewModel.offset)
            .animation(.interactiveSpring(), value: gameViewModel.offset)
            .onChange(of: block.isLit, perform: { _ in SoundManager.shared.playSound(sound: .hitBlock) })
    }

    private func makeBallView(_ ball: BallGameObject, isMainBall: Bool = false) -> some View {
        Image(isMainBall ? Constants.mainBallImage : Constants.extraBallImage)
            .resizable()
            .frame(width: ball.diameter, height: ball.diameter)
            .position(x: ball.physicsBody.position.dx, y: ball.physicsBody.position.dy)
            .offset(x: 0, y: gameViewModel.offset)
            .onChange(of: ball.physicsBody.position.dy) { newY in
                if isMainBall {
                    gameViewModel.setOffset(using: newY)
                }
            }
            .animation(.interactiveSpring(), value: gameViewModel.offset)
            .animation(.interactiveSpring(), value: ball.radius)
    }

    private func overlayBucketView() -> some View {
        Image(Constants.bucketImage)
            .resizable()
            .frame(width: Constants.bucketWidth, height: Constants.bucketHeight)
            .position(x: gameViewModel.bucket.physicsBody.position.dx, y: gameViewModel.bucket.physicsBody.position.dy)
            .offset(x: 0, y: gameViewModel.offset)
    }

    private var scoreAndTimerView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Score:").font(.title2).bold()
                Text(String(gameViewModel.score)).font(.title2)
            }

            HStack {
                Text("Time Left:").font(.title2).bold()
                Text("\(gameViewModel.timeLeft)s").font(.title2)
            }
        }
    }

    private var dragGestureForShoot: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged({ value in
                let point = CGPoint(
                    x: value.location.x,
                    y: max(value.location.y, Constants.initialBallLaunchYCoordinate)
                )
                rotateState = gameViewModel.getAngleForCanon(using: point)
            })
            .onEnded({ value in
                let point = CGPoint(
                    x: value.location.x,
                    y: max(value.location.y, Constants.initialBallLaunchYCoordinate)
                )
                if gameViewModel.isCannonLoaded {
                    SoundManager.shared.playSound(sound: .shoot)
                }
                gameViewModel.shootBallTowards(point: point)
            })
    }
}
