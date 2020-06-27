//
//  AttachDatabaseTests.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 6/25/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftQLiteQuery
import XCTest

final class AttachDatabaseTests: XCTestCase {
    func testInit() {
        let expression = Expression(literal: .string("testInit_Expression"))
        let schemaName = SchemaName("testInit_schemaName")
        let attachDatabase = AttachDatabase(expression, as: schemaName)
        XCTAssertEqual("ATTACH DATABASE 'testInit_Expression' AS testInit_schemaName", attachDatabase.statementValue)
    }
}
