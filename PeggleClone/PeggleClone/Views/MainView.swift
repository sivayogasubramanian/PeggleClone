//
//  MainView.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 26/2/22.
//

import SwiftUI

struct MainView: View {
    @State private var isShowingPlayableLevelsView = false
    @State private var isShowingLevelDesigner = false

    var body: some View {
        Image(Constants.mainBackgroundImage)
            .offset(x: 25)
            .overlay {
                VStack(spacing: 50) {
                    playGameButtonView
                    designLevelButtonView
                }.offset(y: 400)
            }
            .statusBar(hidden: true)
            .ignoresSafeArea(.keyboard)
            .edgesIgnoringSafeArea([.top, .bottom])
    }

    private var playGameButtonView: some View {
        Button("Play Game", action: { isShowingPlayableLevelsView = true })
            .buttonStyle(GrowingButton())
            .fullScreenCover(isPresented: $isShowingPlayableLevelsView) {
                PlayableLevelsView()
            }
    }

    private var designLevelButtonView: some View {
        Button("Design Level", action: { isShowingLevelDesigner = true })
            .buttonStyle(GrowingButton())
            .fullScreenCover(isPresented: $isShowingLevelDesigner) {
                DesignerView()
            }
    }
}
