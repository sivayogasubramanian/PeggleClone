//
//  GrowingButton.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 26/2/22.
//

import Foundation
import SwiftUI

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.primary)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.4 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
