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
        XCTAssertTrue(type(of: viewModel.currentAction) == AddBluePegAction.self)
    }

    func testSetAction() {
        viewModel.setAction(to: DeletePegAction())
        XCTAssertTrue(type(of: viewModel.currentAction) == DeletePegAction.self)
    }

    func testGetPegColor() {
        XCTAssertEqual(viewModel.getPegColor(), .blue)
        viewModel.setAction(to: AddOrangePegAction())
        XCTAssertEqual(viewModel.getPegColor(), .orange)
        viewModel.setAction(to: DeletePegAction())
        XCTAssertNil(viewModel.getPegColor())
    }
}
