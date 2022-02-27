//
//  GameObjectCounterView.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 26/2/22.
//

import SwiftUI

struct GameObjectCounterView: View {
    let blue: Int
    let orange: Int
    let purple: Int
    let gray: Int
    let yellow: Int
    let pink: Int
    let balls: Int

    var body: some View {
        HStack {
            ImageCounterView(image: Constants.orangePegImage, count: orange, color: .black, isCircle: true)
            if blue > 0 {
                ImageCounterView(image: Constants.bluePegImage, count: blue, color: .black, isCircle: true)
            }
            if purple > 0 {
                ImageCounterView(image: Constants.purplePegImage, count: purple, color: .black, isCircle: true)
            }
            if gray > 0 {
                ImageCounterView(image: Constants.grayPegImage, count: gray, color: .black, isCircle: true)
            }
            if yellow > 0 {
                ImageCounterView(image: Constants.yellowPegImage, count: yellow, color: .black, isCircle: true)

            }
            if pink > 0 {
                ImageCounterView(image: Constants.pinkPegImage, count: pink, color: .black, isCircle: true)
            }
            ImageCounterView(image: Constants.mainBallImage, count: balls, color: .black, isCircle: true)
        }
    }
}
