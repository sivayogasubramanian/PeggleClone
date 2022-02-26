//
//  DesignerObjectCounterView.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 26/2/22.
//

import SwiftUI

struct DesignerObjectCounterView: View {
    let bluePeg: Int
    let orangePeg: Int
    let purplePeg: Int
    let grayPeg: Int
    let blueBlock: Int
    let orangeBlock: Int
    let purpleBlock: Int
    let grayBlock: Int

    var body: some View {
        HStack {
            ImageCounterView(image: Constants.orangePegImage, count: orangePeg, color: .black, isCircle: true)
            ImageCounterView(image: Constants.bluePegImage, count: bluePeg, color: .black, isCircle: true)
            ImageCounterView(image: Constants.purplePegImage, count: purplePeg, color: .black, isCircle: true)
            ImageCounterView(image: Constants.grayPegImage, count: grayPeg, color: .black, isCircle: true)
            ImageCounterView(image: Constants.orangeTriangularBlockImage, count: orangeBlock,
                             color: .black, isCircle: false)
            ImageCounterView(image: Constants.blueTriangularBlockImage, count: blueBlock,
                             color: .black, isCircle: false)
            ImageCounterView(image: Constants.purpleTriangularBlockImage, count: purpleBlock,
                             color: .black, isCircle: false)
            ImageCounterView(image: Constants.grayTriangularBlockImage, count: grayBlock,
                             color: .black, isCircle: false)
        }
    }
}
