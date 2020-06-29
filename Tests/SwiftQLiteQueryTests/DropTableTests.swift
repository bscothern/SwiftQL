//
//  DropTableTests.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 6/29/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftQLiteQuery
import XCTest

final class DropTableTests: XCTestCase {
    let tableName: TableName = "DropTable_TableName"
    let schemaName: SchemaName = "DropTable_SchemaName"

    func testInitName() {
        let dropTable = DropTable(name: tableName)
        XCTAssertEqual("DROP TABLE IF EXISTS \(tableName.substatementValue)", dropTable.statementValue)
    }

    func testInitNameIfExists() {
        let dropTable = DropTable(name: tableName, ifExists: true)
        XCTAssertEqual("DROP TABLE IF EXISTS \(tableName.substatementValue)", dropTable.statementValue)
    }

    func testInitNameNoIfExists() {
        let dropTable = DropTable(name: tableName, ifExists: false)
        XCTAssertEqual("DROP TABLE \(tableName.substatementValue)", dropTable.statementValue)
    }

    func testInitSchemaNameTableName() {
        let dropTable = DropTable(schemaName: schemaName, name: tableName)
        XCTAssertEqual("DROP TABLE IF EXISTS \(schemaName.substatementValue).\(tableName.substatementValue)", dropTable.statementValue)
    }

    func testInitSchemaNameTableNameIfExists() {
        let dropTable = DropTable(schemaName: schemaName, name: tableName, ifExists: true)
        XCTAssertEqual("DROP TABLE IF EXISTS \(schemaName.substatementValue).\(tableName.substatementValue)", dropTable.statementValue)
    }

    func testInitSchemaNameTableNameNoIfExists() {
        let dropTable = DropTable(schemaName: schemaName, name: tableName, ifExists: false)
        XCTAssertEqual("DROP TABLE \(schemaName.substatementValue).\(tableName.substatementValue)", dropTable.statementValue)
    }
}
