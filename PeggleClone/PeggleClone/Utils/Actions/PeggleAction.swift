//
//  PegAction.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 19/2/22.
//

enum PeggleType {
    case peg, block
}

protocol PeggleAction {
    func getPeggleType() -> PeggleType?
    func getColor() -> PeggleColor?
    func getDescription() -> String?
}
