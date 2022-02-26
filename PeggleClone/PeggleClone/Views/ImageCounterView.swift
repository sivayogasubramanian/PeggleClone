//
//  ImageCounterView.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 26/2/22.
//

import SwiftUI

struct ImageCounterView: View {
    let image: String
    let count: Int
    let color: Color
    let isCircle: Bool

    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 40, height: 40)
            .overlay {
                Text(String(count))
                    .bold()
                    .font(.title3)
                    .foregroundColor(color)
                    .offset(y: isCircle ? 0 : 5)
            }
    }
}
