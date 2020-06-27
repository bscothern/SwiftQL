//
//  DetachDatabaseTests.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 6/25/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftQLiteQuery
import XCTest

final class DetachDatabaseTests: XCTestCase {
    func testInit() {
        let detachDatabase = DetachDatabase()
        XCTAssertEqual("DETACH DATABASE", detachDatabase.statementValue)
    }

    func testInitWithSchemaName() {
        let schemaName: SchemaName = "DetachDatabase_SchemaName"
        let detachDatabase = DetachDatabase(schemaName: schemaName)
        XCTAssertEqual("DETACH DATABASE \(schemaName.substatementValue)", detachDatabase.statementValue)
    }
}
