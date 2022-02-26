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
        VStack(alignment: .leading) {
            Text(actionsViewModel.currentAction.getDescription() ?? "")
                .foregroundColor(.gray)

            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    imageButtonViewCollection
                }

                Spacer()

                objectAttributeAdjusterViewCollection

                Spacer()

                deletePegImageButtonView
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 125)
    }

    private var imageButtonViewCollection: some View {
        HStack {
            orangePegImageButtonView
            bluePegImageButtonView
            purplePegImageButtonView
            grayPegImageButtonView
            yellowPegImageButtonView
            orangeTriangularBlockButtonView
            blueTriangularBlockButtonView
            purpleTriangularBlockButtonView
            grayTriangularBlockButtonView
            yellowTriangularBlockButtonView
        }
    }

    private var objectAttributeAdjusterViewCollection: some View {
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
    }

    private var orangePegImageButtonView: some View {
        IndividualImageButtonView(
            designerViewModel: designerViewModel,
            actionsViewModel: actionsViewModel,
            image: Constants.orangePegImage,
            action: AddOrangePegAction(),
            actionType: AddOrangePegAction.self
        )
    }

    private var bluePegImageButtonView: some View {
        IndividualImageButtonView(
            designerViewModel: designerViewModel,
            actionsViewModel: actionsViewModel,
            image: Constants.bluePegImage,
            action: AddBluePegAction(),
            actionType: AddBluePegAction.self
        )
    }

    private var purplePegImageButtonView: some View {
        IndividualImageButtonView(
            designerViewModel: designerViewModel,
            actionsViewModel: actionsViewModel,
            image: Constants.purplePegImage,
            action: AddPurplePegAction(),
            actionType: AddPurplePegAction.self
        )
    }

    private var grayPegImageButtonView: some View {
        IndividualImageButtonView(
            designerViewModel: designerViewModel,
            actionsViewModel: actionsViewModel,
            image: Constants.grayPegImage,
            action: AddGrayPegAction(),
            actionType: AddGrayPegAction.self
        )
    }

    private var yellowPegImageButtonView: some View {
        IndividualImageButtonView(
            designerViewModel: designerViewModel,
            actionsViewModel: actionsViewModel,
            image: Constants.yellowPegImage,
            action: AddYellowPegAction(),
            actionType: AddYellowPegAction.self
        )
    }

    private var orangeTriangularBlockButtonView: some View {
        IndividualImageButtonView(
            designerViewModel: designerViewModel,
            actionsViewModel: actionsViewModel,
            image: Constants.orangeTriangularBlockImage,
            action: AddOrangeTriangularBlockAction(),
            actionType: AddOrangeTriangularBlockAction.self
        )
    }

    private var blueTriangularBlockButtonView: some View {
        IndividualImageButtonView(
            designerViewModel: designerViewModel,
            actionsViewModel: actionsViewModel,
            image: Constants.blueTriangularBlockImage,
            action: AddBlueTriangularBlockAction(),
            actionType: AddBlueTriangularBlockAction.self
        )
    }

    private var purpleTriangularBlockButtonView: some View {
        IndividualImageButtonView(
            designerViewModel: designerViewModel,
            actionsViewModel: actionsViewModel,
            image: Constants.purpleTriangularBlockImage,
            action: AddPurpleTriangularBlockAction(),
            actionType: AddPurpleTriangularBlockAction.self
        )
    }

    private var grayTriangularBlockButtonView: some View {
        IndividualImageButtonView(
            designerViewModel: designerViewModel,
            actionsViewModel: actionsViewModel,
            image: Constants.grayTriangularBlockImage,
            action: AddGrayTriangularBlockAction(),
            actionType: AddGrayTriangularBlockAction.self
        )
    }

    private var yellowTriangularBlockButtonView: some View {
        IndividualImageButtonView(
            designerViewModel: designerViewModel,
            actionsViewModel: actionsViewModel,
            image: Constants.yellowTriangularBlockImage,
            action: AddYellowTriangularBlockAction(),
            actionType: AddYellowTriangularBlockAction.self
        )
    }

    private var deletePegImageButtonView: some View {
        IndividualImageButtonView(
            designerViewModel: designerViewModel,
            actionsViewModel: actionsViewModel,
            image: Constants.deleteButtonImage,
            action: DeleteAction(),
            actionType: DeleteAction.self
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
            Text("Radius:")
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
                Text("Width:")
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
                Text("Height:")
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
