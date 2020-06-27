//
//  CreateIndexTests.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 6/25/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftQLiteQuery
import XCTest

final class CreateIndexTests: XCTestCase {
    let schemaName: SchemaName = "CreateIndexTests_SchemaName"
    let indexName: IndexName = "CreateIndexTests_IndexName"
    let tableName: TableName = "CreateIndexTests_TableName"
    let whereExpression = Expression(columnName: "whereExpression_Column")
        .equals(.init(literal: .numeric(42)))

    func testInitNoSchemaName1() {
        let createIndex = CreateIndex(name: indexName, on: tableName, isUnique: false, columns: "CreateIndexTests_ColumnName1", "CreateIndexTests_ColumnName2")
        XCTAssertEqual("CREATE INDEX IF NOT EXISTS \(indexName.substatementValue) ON \(tableName.substatementValue) (CreateIndexTests_ColumnName1, CreateIndexTests_ColumnName2)", createIndex.statementValue)
    }

    func testInitNoSchemaName2() {
        let createIndex = CreateIndex(name: indexName, on: tableName, isUnique: true, ifNotExists: false, columns: "CreateIndexTests_ColumnName1", "CreateIndexTests_ColumnName2")
        XCTAssertEqual("CREATE UNIQUE INDEX \(indexName.substatementValue) ON \(tableName.substatementValue) (CreateIndexTests_ColumnName1, CreateIndexTests_ColumnName2)", createIndex.statementValue)
    }

    func testInitNoSchemaName3() {
        let createIndex = CreateIndex(name: indexName, on: tableName, isUnique: false, ifNotExists: false, columns: "CreateIndexTests_ColumnName1", "CreateIndexTests_ColumnName2", where: whereExpression)
        XCTAssertEqual("CREATE INDEX \(indexName.substatementValue) ON \(tableName.substatementValue) (CreateIndexTests_ColumnName1, CreateIndexTests_ColumnName2) WHERE whereExpression_Column == 42", createIndex.statementValue)
    }

    func testInitSchemaName1() {
        let createIndex = CreateIndex(schemaName: schemaName, name: indexName, on: tableName, isUnique: false, columns: "CreateIndexTests_ColumnName1", "CreateIndexTests_ColumnName2")
        XCTAssertEqual("CREATE INDEX IF NOT EXISTS \(schemaName.substatementValue).\(indexName.substatementValue) ON \(tableName.substatementValue) (CreateIndexTests_ColumnName1, CreateIndexTests_ColumnName2)", createIndex.statementValue)
    }

    func testInitSchemaName2() {
        let createIndex = CreateIndex(schemaName: schemaName, name: indexName, on: tableName, isUnique: true, ifNotExists: false, columns: "CreateIndexTests_ColumnName1", "CreateIndexTests_ColumnName2")
        XCTAssertEqual("CREATE UNIQUE INDEX \(schemaName.substatementValue).\(indexName.substatementValue) ON \(tableName.substatementValue) (CreateIndexTests_ColumnName1, CreateIndexTests_ColumnName2)", createIndex.statementValue)
    }

    func testInitSchemaName3() {
        let createIndex = CreateIndex(schemaName: schemaName, name: indexName, on: tableName, isUnique: false, ifNotExists: false, columns: "CreateIndexTests_ColumnName1", "CreateIndexTests_ColumnName2", where: whereExpression)
        XCTAssertEqual("CREATE INDEX \(schemaName.substatementValue).\(indexName.substatementValue) ON \(tableName.substatementValue) (CreateIndexTests_ColumnName1, CreateIndexTests_ColumnName2) WHERE whereExpression_Column == 42", createIndex.statementValue)
    }
}
