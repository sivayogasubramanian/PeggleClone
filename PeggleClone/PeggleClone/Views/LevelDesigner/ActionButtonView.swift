//
//  ActionButtonView.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 22/1/22.
//

import SwiftUI

struct ActionButtonView: View {
    // To take a screenshot when saving a level
    var boardView: DesignerBoardView

    @ObservedObject var designerViewModel: DesignerViewModel
    @ObservedObject var actionsViewModel: DesignerActionsViewModel

    // TextField states
    @State private var levelName: String
    @FocusState private var textFieldIsFocused: Bool

    // Alert states
    @State private var showingResetAlert = false
    @State private var showingSaveAlert = false
    @State private var showingLoadAlert = false
    @State private var showingSavedLevels = false
    @State private var isSaveSuccess = false

    // Game state
    @State private var isGameActive = false

    init(boardView: DesignerBoardView,
         designerViewModel: DesignerViewModel,
         actionsViewModel: DesignerActionsViewModel
    ) {
        self.boardView = boardView
        self.designerViewModel = designerViewModel
        self.actionsViewModel = actionsViewModel
        levelName = designerViewModel.board.name
    }

    var body: some View {
        HStack {
            HStack {
                loadButtonView

                saveButtonView

                resetButtonView
            }
            .padding(.trailing, 10)

            levelNameTextFieldView

            playButtonView
        }
        .padding(.horizontal, 25)
        .padding(.top, 10)
    }

    private var loadButtonView: some View {
        Button("LOAD", action: {
            showingLoadAlert = true
            textFieldIsFocused = false
            SoundManager.shared.playSound(sound: .click)

        })
        .alert(
            "Please remember to save your progress. Any progress made will be lost if it is not saved.",
            isPresented: $showingLoadAlert,
            actions: {
                Button("Cancel", role: .cancel, action: {})
                Button("Ok", role: .destructive, action: { showingSavedLevels = true })
            })
        .fullScreenCover(
            isPresented: $showingSavedLevels,
            onDismiss: { levelName = designerViewModel.board.name },
            content: { SavedLevelsView(levelName: $levelName, designerViewModel: designerViewModel) }
        )
    }

    private var saveButtonView: some View {
        Button("SAVE", action: {
            showingSaveAlert = true
            textFieldIsFocused = false
            SoundManager.shared.playSound(sound: .click)
        })
        .disabled(levelName.isEmpty)
        .alert("Are you sure you want to save this level?", isPresented: $showingSaveAlert, actions: {
            Button("Cancel", role: .cancel, action: {})
            Button("Yes", action: { saveButtonHandler() })
        })
        .alert("Successfully saved level!", isPresented: $isSaveSuccess, actions: {})
    }

    private var resetButtonView: some View {
        Button("RESET", action: {
            showingResetAlert = true
            SoundManager.shared.playSound(sound: .click)
        })
        .alert("Are you sure you want to reset this level?", isPresented: $showingResetAlert) {
            Button("Cancel", role: .cancel, action: {})
            Button("Yes", role: .destructive, action: { resetButtonHandler() })
        }
    }

    private var playButtonView: some View {
        Button("TRIAL PLAY", action: {
            isGameActive = true
            textFieldIsFocused = false
            SoundManager.shared.playSound(sound: .click)
        })
        .fullScreenCover(
            isPresented: $isGameActive,
            content: {
                GameView(gameViewModel: GameViewModel(board: designerViewModel.board))
            }
        )
    }

    private var levelNameTextFieldView: some View {
        TextField("Level Name", text: $levelName)
            .textFieldStyle(.roundedBorder)
            .focused($textFieldIsFocused)
    }
}

extension ActionButtonView {
    private func saveButtonHandler() {
        designerViewModel.setBoardName(to: levelName.trimmingCharacters(in: .whitespacesAndNewlines))
        designerViewModel.setImageData(from: boardView)
        designerViewModel.saveBoard()
        isSaveSuccess = true
        textFieldIsFocused = false
    }

    private func resetButtonHandler() {
        designerViewModel.resetDesigner()
        textFieldIsFocused = false
        levelName = ""
    }
}
