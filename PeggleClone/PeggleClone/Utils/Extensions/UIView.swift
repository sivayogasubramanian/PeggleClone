//
//  UIViewExtensions.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/1/22.
//

import SwiftUI

extension UIView {
    func asImage() -> UIImage {
        UIGraphicsImageRenderer(
            size: layer.frame.size,
            format: UIGraphicsImageRendererFormat()
        ).image { _ in
            drawHierarchy(in: layer.bounds, afterScreenUpdates: true)
        }
    }
}
