//
//  Board+ComputedProperties.swift
//  PeggleClone
//
//  Created by Sivayogasubramanian on 27/2/22.
//

extension Board {
    var orangePegsCount: Int {
        pegs.filter({ $0.color == .orange }).count
    }
    var bluePegsCount: Int {
        pegs.filter({ $0.color == .blue }).count
    }
    var purplePegsCount: Int {
        pegs.filter({ $0.color == .purple }).count
    }
    var grayPegsCount: Int {
        pegs.filter({ $0.color == .gray }).count
    }
    var yellowPegsCount: Int {
        pegs.filter({ $0.color == .yellow }).count
    }
    var pinkPegsCount: Int {
        pegs.filter({ $0.color == .pink }).count
    }
    var orangeBlocksCount: Int {
        blocks.filter({ $0.color == .orange }).count
    }
    var blueBlocksCount: Int {
        blocks.filter({ $0.color == .blue }).count
    }
    var purpleBlocksCount: Int {
        blocks.filter({ $0.color == .purple }).count
    }
    var grayBlocksCount: Int {
        blocks.filter({ $0.color == .gray }).count
    }
    var yellowBlocksCount: Int {
        blocks.filter({ $0.color == .yellow }).count
    }
    var pinkBlocksCount: Int {
        blocks.filter({ $0.color == .pink }).count
    }
}
