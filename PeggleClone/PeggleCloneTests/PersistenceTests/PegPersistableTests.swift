//
//  Peg+PersistableTests.swift
//  PeggleCloneTests
//
//  Created by Sivayogasubramanian on 29/1/22.
//

import CoreData
import XCTest
@testable import PeggleClone

class PegPersistableTests: XCTestCase {
    private var viewContext: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        viewContext = TestCoreDataManager().viewContext
    }

    override func tearDown() {
        viewContext = nil
        super.tearDown()
    }

    func testFromCoreDataEntity() {
        let uuid = UUID(), color = PeggleColor.orange
        let xCoord = 56.1, yCoord = 121.23

        let pegEntity = PegEntity(context: viewContext)
        pegEntity.setId(to: uuid)
        pegEntity.setColor(to: color)
        pegEntity.setXCoord(to: xCoord)
        pegEntity.setYCoord(to: yCoord)

        let peg = Peg.fromCoreDataEntity(pegEntity)
        let expectedPeg = Peg(uuid: uuid, color: color, center: CGVector(dx: xCoord, dy: yCoord))

        XCTAssertEqual(peg.uuid, expectedPeg.uuid)
        XCTAssertEqual(peg.color, expectedPeg.color)
        XCTAssertEqual(peg.center, expectedPeg.center)
    }

    func testToCoreDataEntity() {
        let uuid = UUID(), color = PeggleColor.blue
        let xCoord = 56.1, yCoord = 121.23

        let peg = Peg(uuid: uuid, color: color, center: CGVector(dx: xCoord, dy: yCoord))
        let pegEntity = peg.toCoreDataEntity(using: viewContext)

        XCTAssertEqual(pegEntity.uuid, uuid)
        XCTAssertEqual(pegEntity.color, color)
        XCTAssertEqual(pegEntity.xCoord, xCoord)
        XCTAssertEqual(pegEntity.yCoord, yCoord)
    }
}
