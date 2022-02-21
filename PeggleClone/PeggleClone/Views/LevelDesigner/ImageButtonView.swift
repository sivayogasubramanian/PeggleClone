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

            blueTriangularBlockButtonView

            orangeTriangularBlockButtonView

            Spacer()

            deletePegImageButtonView
        }
        .padding(.horizontal, 20)
    }

    private var bluePegImageButtonView: some View {
        Image(Constants.bluePegImage)
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
        Image(Constants.orangePegImage)
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

    private var blueTriangularBlockButtonView: some View {
        Image(Constants.blueTriangularBlockImage)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100, alignment: .center)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    actionsViewModel.setAction(to: AddBlueTriangularBlockAction())
                }
            }
            .opacity(
                type(of: actionsViewModel.currentAction) == AddBlueTriangularBlockAction.self
                ? ImageButtonView.selectedOpacity
                : ImageButtonView.notSelectedOpacity
            )
    }

    private var orangeTriangularBlockButtonView: some View {
        Image(Constants.orangeTriangularBlockImage)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100, alignment: .center)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    actionsViewModel.setAction(to: AddOrangeTriangularBlockAction())
                }
            }
            .opacity(
                type(of: actionsViewModel.currentAction) == AddOrangeTriangularBlockAction.self
                ? ImageButtonView.selectedOpacity
                : ImageButtonView.notSelectedOpacity
            )
    }

    private var deletePegImageButtonView: some View {
        Image(Constants.deleteButtonImage)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100, alignment: .center)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    actionsViewModel.setAction(to: DeleteAction())
                }
            }
            .opacity(
                type(of: actionsViewModel.currentAction) == DeleteAction.self
                ? ImageButtonView.selectedOpacity
                : ImageButtonView.notSelectedOpacity
            )
    }
}
