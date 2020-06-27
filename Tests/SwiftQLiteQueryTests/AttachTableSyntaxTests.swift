//
//  AttachTableSyntaxTests.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 5/14/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftQLiteQuery
import XCTest

final class AttachTableSyntaxTests: XCTestCase {
    func testInit() {
        let expression: Expression = .init(literal: .string("FakeDatabaseName"))
        let schemaName: SchemaName = "TestInitSchemaName"

        let attachDatabase = AttachDatabase(expression, as: schemaName)

        XCTAssertEqual("ATTACH DATABASE 'FakeDatabaseName' AS TestInitSchemaName", attachDatabase.statementValue)
    }
}
