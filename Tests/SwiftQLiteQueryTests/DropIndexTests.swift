//
//  DropIndexTests.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 6/25/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftQLiteQuery
import XCTest

final class DropIndexTests: XCTestCase {
    let indexName: IndexName = "DropIndex_IndexName"
    let schemaName: SchemaName = "DropIndex_SchemaName"

    func testInitName() {
        let dropIndex = DropIndex(name: indexName)
        XCTAssertEqual("DROP INDEX IF EXISTS \(indexName.substatementValue)", dropIndex.statementValue)
    }

    func testInitNameIfExists() {
        let dropIndex = DropIndex(name: indexName, ifExists: true)
        XCTAssertEqual("DROP INDEX IF EXISTS \(indexName.substatementValue)", dropIndex.statementValue)
    }

    func testInitNameNoIfExists() {
        let dropIndex = DropIndex(name: indexName, ifExists: false)
        XCTAssertEqual("DROP INDEX \(indexName.substatementValue)", dropIndex.statementValue)
    }

    func testInitSchemaNameIndexName() {
        let dropIndex = DropIndex(schemaName: schemaName, name: indexName)
        XCTAssertEqual("DROP INDEX IF EXISTS \(schemaName.substatementValue).\(indexName.substatementValue)", dropIndex.statementValue)
    }

    func testInitSchemaNameIndexNameIfExists() {
        let dropIndex = DropIndex(schemaName: schemaName, name: indexName, ifExists: true)
        XCTAssertEqual("DROP INDEX IF EXISTS \(schemaName.substatementValue).\(indexName.substatementValue)", dropIndex.statementValue)
    }

    func testInitSchemaNameIndexNameNoIfExists() {
        let dropIndex = DropIndex(schemaName: schemaName, name: indexName, ifExists: false)
        XCTAssertEqual("DROP INDEX \(schemaName.substatementValue).\(indexName.substatementValue)", dropIndex.statementValue)
    }
}
