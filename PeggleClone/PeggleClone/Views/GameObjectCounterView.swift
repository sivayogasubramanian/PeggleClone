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
    let balls: Int

    var body: some View {
        HStack {
            ImageCounterView(image: Constants.bluePegImage, count: blue, color: .black)
            ImageCounterView(image: Constants.orangePegImage, count: orange, color: .black)
            ImageCounterView(image: Constants.purplePegImage, count: purple, color: .black)
            ImageCounterView(image: Constants.ballImage, count: balls, color: .black)
        }
    }
}
