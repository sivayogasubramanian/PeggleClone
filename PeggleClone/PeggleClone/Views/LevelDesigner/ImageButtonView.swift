//
//  ImageButtonView.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/1/22.
//

import SwiftUI

struct ImageButtonView: View {
    private static let selectedOpacity = 1.0
    private static let notSelectedOpacity = 0.3

    @ObservedObject var actionsViewModel: DesignerActionsViewModel

    var body: some View {
        HStack(spacing: 40) {
            bluePegImageButtonView

            orangePegImageButtonView

            Spacer()

            deletePegImageButtonView
        }
        .padding(.horizontal, 20)
    }

    private var bluePegImageButtonView: some View {
        Image(Constants.bluePegImageFileName)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100, alignment: .center)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    actionsViewModel.setAction(to: AddBluePegAction())
                }
            }
            .opacity(
                type(of: actionsViewModel.currentAction) == AddBluePegAction.self
                ? ImageButtonView.selectedOpacity
                : ImageButtonView.notSelectedOpacity
            )
    }

    private var orangePegImageButtonView: some View {
        Image(Constants.orangePegImageFileName)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100, alignment: .center)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    actionsViewModel.setAction(to: AddOrangePegAction())
                }
            }
            .opacity(
                type(of: actionsViewModel.currentAction) == AddOrangePegAction.self
                ? ImageButtonView.selectedOpacity
                : ImageButtonView.notSelectedOpacity
            )
    }

    private var deletePegImageButtonView: some View {
        Image(Constants.deleteButtonImageFileName)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100, alignment: .center)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    actionsViewModel.setAction(to: DeletePegAction())
                }
            }
            .opacity(
                type(of: actionsViewModel.currentAction) == DeletePegAction.self
                ? ImageButtonView.selectedOpacity
                : ImageButtonView.notSelectedOpacity
            )
    }
}
