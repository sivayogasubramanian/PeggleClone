//
//  ViewExtentions.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/1/22.
//

import CoreGraphics
import Foundation
import SwiftUI

extension View {
    func asImage(size: CGSize) -> UIImage {
        let controller = UIHostingController(rootView: ignoresSafeArea(.all))
        controller.view.bounds = CGRect(origin: .zero, size: size)
        return controller.view.asImage()
    }
}
