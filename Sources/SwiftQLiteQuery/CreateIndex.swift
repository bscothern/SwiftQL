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
        let columns = self.columns.joined(separator: ", ")
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
    let name: String

    @usableFromInline
    let tableName: TableName

    @usableFromInline
    let columns: [String]

    @usableFromInline
    let `where`: Expression?

    @inlinable
    public init(name: String, on tableName: TableName, schemaName: SchemaName? = nil, columns: String..., isUnique: Bool, ifNotExists: Bool = true, where: Expression? = nil) {
        self.init(name: name, on: tableName, schemaName: schemaName, columns: columns, isUnique: isUnique, ifNotExists: ifNotExists, where: `where`)
    }

    @inlinable
    public init(name: String, on tableName: TableName, schemaName: SchemaName? = nil, columns: [String], isUnique: Bool, ifNotExists: Bool = true, where: Expression? = nil) {
        self.isUnique = isUnique
        self.ifNotExists = ifNotExists
        self.schemaName = schemaName
        self.name = name
        self.tableName = tableName
        self.columns = columns
        self.where = `where`
    }
}
