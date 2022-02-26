//
//  PlayableLevelsView.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 26/2/22.
//

import SwiftUI

struct PlayableLevelsView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var designerViewModel = DesignerViewModel()
    @State private var savedBoards: [Board] = []
    @State private var isGameActive: [Bool] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(0..<savedBoards.count, id: \.self) { index in
                    makeButtonViewForBoard(index)
                }
            }
            .navigationTitle("Levels")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    backButtonView
                })
            }
        }
        .onAppear(perform: {
            onAppearHandler()
        })
        .statusBar(hidden: true)
        .ignoresSafeArea(.keyboard)
        .edgesIgnoringSafeArea([.top, .bottom])
    }

    private func makeButtonViewForBoard(_ index: Int) -> some View {
        let board = savedBoards[index]
        return Button(action: { isGameActive[index] = true }, label: {
            if let uiImage = UIImage(data: board.snapshot) {
                Image(uiImage: uiImage).resizable().scaledToFit()
            }
            HStack {
                Text("\(board.name)").font(.title2).bold()
                if board.maxHeight > board.boardSize.height {
                    Text("(Scrolling Level)").font(.title2)
                }
            }
        })
        .foregroundColor(.primary)
        .padding(15)
        .fullScreenCover(isPresented: $isGameActive[index]) {
            GameView(gameViewModel: GameViewModel(board: board))
        }
    }

    private var backButtonView: some View {
        Button(action: {
            dismiss()
        }, label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
        })
    }
}

extension PlayableLevelsView {
    private func onAppearHandler() {
        savedBoards.append(contentsOf: Seeder(for: UIScreen.screenSize).makeSeedLevels())
        savedBoards.append(contentsOf: designerViewModel.loadSavedLevels())
        isGameActive.append(contentsOf: Array(1...savedBoards.count).map { _ in false })
    }
}
