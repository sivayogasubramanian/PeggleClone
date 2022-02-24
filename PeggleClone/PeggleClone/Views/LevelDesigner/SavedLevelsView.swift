//
//  SavedLevelsView.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 25/1/22.
//

import SwiftUI

struct SavedLevelsView: View {
    @Environment(\.presentationMode) private var presentationMode

    @Binding var levelName: String
    @ObservedObject var designerViewModel: DesignerViewModel

    @State private var savedBoards: [Board] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(savedBoards) { board in
                    makeButtonViewForBoard(board)
                }
            }
            .navigationTitle("Select a level to load")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    createLevelButtonView
                })
            }
            .overlay {
                if savedBoards.isEmpty {
                    Text("No saved levels present").foregroundColor(.gray).font(.title3)
                }
            }
        }
        .onAppear(perform: {
            onAppearHandler()
        })
    }

    private func makeButtonViewForBoard(_ board: Board) -> some View {
        Button(action: {
            selectLevelButtonHandler(board: board)
        }, label: {
            if let uiImage = UIImage(data: board.snapshot) {
                Image(uiImage: uiImage).resizable().scaledToFit()
            }
            Text("\(board.name)").font(.title2)
        })
            .foregroundColor(.primary)
            .padding(15)
    }

    private var createLevelButtonView: some View {
        Button(action: {
            createLevelButtonHandler()
        }, label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Create New Level")
            }
        })
    }
}

extension SavedLevelsView {
    private func selectLevelButtonHandler(board: Board) {
        designerViewModel.setBoard(to: board)
        levelName = board.name
        presentationMode.wrappedValue.dismiss()
    }

    private func createLevelButtonHandler() {
        levelName = ""
        designerViewModel.resetDesigner()
        presentationMode.wrappedValue.dismiss()
    }

    private func onAppearHandler() {
        savedBoards.append(contentsOf: Seeder(for: designerViewModel.boardSize).makeSeedLevels())
        savedBoards.append(contentsOf: designerViewModel.loadSavedLevels())
    }
}
