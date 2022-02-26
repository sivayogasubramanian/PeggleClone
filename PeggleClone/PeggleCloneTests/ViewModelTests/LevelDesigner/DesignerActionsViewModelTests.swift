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
        XCTAssertTrue(type(of: viewModel.currentAction) == AddOrangePegAction.self)
    }

    func testSetAction() {
        viewModel.setAction(to: DeleteAction())
        XCTAssertTrue(type(of: viewModel.currentAction) == DeleteAction.self)
    }

    func testGetPegColor() {
        XCTAssertEqual(viewModel.getColor(), .orange)
        viewModel.setAction(to: AddBluePegAction())
        XCTAssertEqual(viewModel.getColor(), .blue)
        viewModel.setAction(to: DeleteAction())
        XCTAssertNil(viewModel.getColor())
    }
}
