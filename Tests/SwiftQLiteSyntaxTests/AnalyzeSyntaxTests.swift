//
//  AnalyzeSyntaxTests.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/24/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftQLite
import XCTest

final class AnalyzeSyntaxTests: XCTestCase {
    func testInitSchema() {
        let schemaName: SchemaName = "testInitSchema"
        let analyze = Analyze(schemaName: schemaName)
        XCTAssertEqual("ANALYZE testInitSchema", analyze.statementValue)
    }

    func testInitTable() {
        let tableName: TableName = "testInitTable"
        let analyze = Analyze(tableName: tableName)
        XCTAssertEqual("ANALYZE testInitTable", analyze.statementValue)
    }

    func testInitIndex() {
        let indexName: IndexName = "testInitIndex"
        let analyze = Analyze(indexName: indexName)
        XCTAssertEqual("ANALYZE testInitIndex", analyze.statementValue)
    }

    func testInitSchemaTable() {
        let schemaName: SchemaName = "testInitSchemaTable_schema"
        let tableName: TableName = "testInitSchemaTable_table"
        let analyze = Analyze(schemaName: schemaName, tableName: tableName)
        XCTAssertEqual("ANALYZE testInitSchemaTable_schema.testInitSchemaTable_table", analyze.statementValue)
    }

    func testInitSchemaIndex() {
        let schemaName: SchemaName = "testInitSchemaIndex_schema"
        let indexName: IndexName = "testInitSchemaIndex_index"
        let analyze = Analyze(schemaName: schemaName, indexName: indexName)
        XCTAssertEqual("ANALYZE testInitSchemaIndex_schema.testInitSchemaIndex_index", analyze.statementValue)
    }
}
