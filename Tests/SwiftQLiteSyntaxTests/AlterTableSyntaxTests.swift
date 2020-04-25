//
//  AlterTableSyntaxTests.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/24/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftQLite
import XCTest

final class AlterTableSyntaxTests: XCTestCase {
    func testInitSchemaTable() {
        let schemaName: SchemaName = "testSchemaName"
        let tableName: TableName = "testTableName"
        
        let alterTable = AlterTable(schemaName: schemaName, tableName: tableName)
        
        XCTAssertEqual("ALTER TABLE testSchemaName.testTableName", alterTable.substatementValue)
    }
    
    func testInitTable() {
        let tableName: TableName = "testTableName"
        
        let alterTable = AlterTable(tableName: tableName)
        
        XCTAssertEqual("ALTER TABLE testTableName", alterTable.substatementValue)
    }
    
    func testRenameTable() {
        let initialTableName: TableName = "initialTableName"
        let finalTableName: TableName = "finalTableName"
        
        let renameTable = AlterTable(tableName: initialTableName)
            .rename(to: finalTableName)
        
        XCTAssertEqual("ALTER TABLE initialTableName RENAME TO finalTableName", renameTable.statementValue)
    }
    
    func testRenameColumn() {
        let tableName: TableName = "testTableName"
        let initialColumnName: ColumnName = "initialColumnName"
        let finalColumnName: ColumnName = "finalColumnName"
        
        let renameColumn = AlterTable(tableName: tableName)
            .rename(column: initialColumnName, to: finalColumnName)
        
        XCTAssertEqual("ALTER TABLE testTableName RENAME COLUMN initialColumnName to finalColumnName", renameColumn.statementValue)
    }
    
    func testAddColumn() {
        let tableName: TableName = "testTableName"
        let newColumnName: ColumnName = "newColumnName"
        
        let addColumn = AlterTable(tableName: tableName)
            .addColumn(.init(name: newColumnName, type: .int))
        
        XCTAssertEqual("ALTER TABLE testTableName ADD COLUMN newColumnName INTEGER", addColumn.statementValue)
    }
}
