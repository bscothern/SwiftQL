//
//  AlterTable.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 1/30/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

public protocol AlterTableSubstatement: Substatement {}

/// https://www.sqlite.org/lang_altertable.html
public struct AlterTable: AlterTableSubstatement {
    @inlinable
    public var substatementValue: String {
        "ALTER TABLE \(schemaName.map { "\($0)." } ?? "")\(tableName)"
    }

    @usableFromInline
    let schemaName: SchemaName?

    @usableFromInline
    let tableName: TableName

    public init(schemaName: SchemaName, tableName: TableName) {
        self.schemaName = schemaName
        self.tableName = tableName
    }

    public init(tableName: TableName) {
        self.schemaName = nil
        self.tableName = tableName
    }
}

extension AlterTableSubstatement {
    @inlinable
    public func rename(to newTableName: TableName) -> Statement {
        AlterTableRenameTable(self, newTableName: newTableName)
    }

    @inlinable
    public func rename(column: ColumnName, to newColumnName: ColumnName) -> Statement {
        AlterTableRenameColumn(self, column: column, newColumnName: newColumnName)
    }

    @inlinable
    public func addColumn(_ column: Column) -> Statement {
        AlterTableAddColumn(self, column: column)
    }
}
