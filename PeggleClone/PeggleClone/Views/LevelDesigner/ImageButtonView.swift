//
//  ImageButtonView.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/1/22.
//

import SwiftUI

struct ImageButtonView: View {
    private static let imageButtonSize = 70.0
    private static let selectedOpacity = 1.0
    private static let notSelectedOpacity = 0.3

    @ObservedObject var designerViewModel: DesignerViewModel
    @ObservedObject var actionsViewModel: DesignerActionsViewModel

    var body: some View {
        HStack(spacing: 5) {
            bluePegImageButtonView

            orangePegImageButtonView

            blueTriangularBlockButtonView

            orangeTriangularBlockButtonView

            Spacer()

            VStack {
                if designerViewModel.selectedPeg != nil || designerViewModel.selectedBlock != nil {
                    rotationAndOscillateSelectorView
                }

                if designerViewModel.selectedPeg != nil {
                    resizePegView
                } else if designerViewModel.selectedBlock != nil {
                    resizeBlockView
                }
            }

            Spacer()

            deletePegImageButtonView
        }
        .padding(.horizontal, 20)
        .frame(height: 100)
    }

    private var bluePegImageButtonView: some View {
        Image(Constants.bluePegImage)
            .resizable()
            .scaledToFit()
            .frame(width: ImageButtonView.imageButtonSize, height: ImageButtonView.imageButtonSize)
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
            .frame(width: ImageButtonView.imageButtonSize, height: ImageButtonView.imageButtonSize)
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
            .frame(width: ImageButtonView.imageButtonSize, height: ImageButtonView.imageButtonSize)
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
            .frame(width: ImageButtonView.imageButtonSize, height: ImageButtonView.imageButtonSize)
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
            .frame(width: ImageButtonView.imageButtonSize, height: ImageButtonView.imageButtonSize)
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

    private var rotationAndOscillateSelectorView: some View {
        HStack {
            Text("Rotation:")
            Slider(
                value: Binding(
                    get: { designerViewModel.rotation },
                    set: { newRotation, _ in
                        designerViewModel.setRotation(to: newRotation)
                    }),
                in: 0...360, step: 1.0
            )

            if designerViewModel.selectedBlock != nil {
                Toggle("Oscillate:", isOn: Binding(get: {
                    designerViewModel.showSpringinessCircle
                }, set: { _, _ in
                    designerViewModel.toggleSpringinessCircle()
                })
                )
            }
        }
    }

    private var resizePegView: some View {
        HStack {
            Text("Radius:   ")
            Slider(
                value: Binding(
                    get: { designerViewModel.radius },
                    set: { newRadius, _ in
                        designerViewModel.setPegRadius(to: newRadius)
                    }),
                in: Constants.pegRadius...Constants.pegRadius * 2, step: 1.0
            )
        }
    }

    private var resizeBlockView: some View {
        HStack {
            HStack {
                Text("Width:    ")
                Slider(
                    value: Binding(
                        get: { designerViewModel.width },
                        set: { newWidth, _ in
                            designerViewModel.setBlockWidth(to: newWidth)
                        }),
                    in: Constants.blockWidth...Constants.blockWidth * 2, step: 1.0
                )
            }

            HStack {
                Text("Height:   ")
                Slider(
                    value: Binding(
                        get: { designerViewModel.height },
                        set: { newHeight, _ in
                            designerViewModel.setBlockHeight(to: newHeight)
                        }),
                    in: Constants.blockHeight...Constants.blockHeight * 2, step: 1.0
                )
            }
        }
    }
}
