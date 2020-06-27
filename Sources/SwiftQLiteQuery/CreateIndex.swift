//
//  CreateIndex.swift
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

public struct CreateIndex: Statement {
    @inlinable
    public var statementValue: String {
        let isUnique = self.isUnique ? "UNIQUE " : ""
        let ifNotExists = self.ifNotExists ? "IF NOT EXISTS " : ""
        let schemaName = self.schemaName.map { "\($0)."} ?? ""
        let columns = self.columns.lazy
            .map(\.substatementValue)
            .joined(separator: ", ")
        let `where` = self.where.map { " WHERE \($0)" } ?? ""
        return "CREATE \(isUnique)INDEX \(ifNotExists)\(schemaName)\(name) ON \(tableName) (\(columns))\(`where`)"
    }

    @usableFromInline
    let isUnique: Bool

    @usableFromInline
    let ifNotExists: Bool

    @usableFromInline
    let schemaName: SchemaName?

    @usableFromInline
    let name: IndexName

    @usableFromInline
    let tableName: TableName

    @usableFromInline
    let columns: [IndexedColumnName]

    @usableFromInline
    let `where`: Expression?

    @inlinable
    public init(name: IndexName, on tableName: TableName, isUnique: Bool, ifNotExists: Bool = true, columns: IndexedColumnName..., where: Expression? = nil) {
        self.init(name: name, on: tableName, isUnique: isUnique, ifNotExists: ifNotExists, columns: columns, where: `where`)
    }

    @inlinable
    public init(name: IndexName, on tableName: TableName, isUnique: Bool, ifNotExists: Bool = true, columns: [IndexedColumnName], where: Expression? = nil) {
        self.init(schemaName: nil, name: name, on: tableName, isUnique: isUnique, ifNotExists: ifNotExists, columns: columns, where: `where`)
    }

    @inlinable
    public init(schemaName: SchemaName, name: IndexName, on tableName: TableName, isUnique: Bool, ifNotExists: Bool = true, columns: IndexedColumnName..., where: Expression? = nil) {
        self.init(schemaName: schemaName, name: name, on: tableName, isUnique: isUnique, ifNotExists: ifNotExists, columns: columns, where: `where`)
    }

    @inlinable
    public init(schemaName: SchemaName, name: IndexName, on tableName: TableName, isUnique: Bool, ifNotExists: Bool = true, columns: [IndexedColumnName], where: Expression? = nil) {
        self.init(schemaName: Optional(schemaName), name: name, on: tableName, isUnique: isUnique, ifNotExists: ifNotExists, columns: columns, where: `where`)
    }

    @usableFromInline
    init(schemaName: SchemaName?, name: IndexName, on tableName: TableName, isUnique: Bool, ifNotExists: Bool, columns: [IndexedColumnName], where: Expression?) {
        self.schemaName = schemaName
        self.name = name
        self.tableName = tableName
        self.isUnique = isUnique
        self.ifNotExists = ifNotExists
        self.columns = columns
        self.where = `where`
    }
}
