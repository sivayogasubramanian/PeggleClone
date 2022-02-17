//
//  DesignerActionsViewModelTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 28/1/22.
//

import XCTest
@testable import PeggleClone

class DesignerActionsViewModelTests: XCTestCase {
    private var viewModel: DesignerActionsViewModel!

    override func setUp() {
        super.setUp()
        viewModel = DesignerActionsViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testDefaultAction() {
        XCTAssertEqual(viewModel.currentAction, .addBluePeg)
    }

    func testSetAction() {
        viewModel.setAction(to: .deletePeg)
        XCTAssertEqual(viewModel.currentAction, .deletePeg)
    }

    func testGetPegColor() {
        XCTAssertEqual(viewModel.getPegColor(), .blue)
        viewModel.setAction(to: .addOrangePeg)
        XCTAssertEqual(viewModel.getPegColor(), .orange)
        viewModel.setAction(to: .deletePeg)
        XCTAssertNil(viewModel.getPegColor())
    }
}
