//
//  CreateVirtualTable.swift
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

/// https://www.sqlite.org/lang_createvtab.html
public struct CreateVirtualTable: Statement {
    public var statementValue: String {
        let ifNotExists = self.ifNotExists ? " IF NOT EXISTS" : ""
        let schemaName = self.schemaName.map { "\($0)." } ?? ""
        let moduleArguments = !self.moduleArguments.isEmpty ? " (\(self.moduleArguments.joined(separator: ", ")))" : ""
        return "CREATE VIRTUAL TABLE\(ifNotExists) \(schemaName)\(tableName) USING \(moduleName)\(moduleArguments)"
    }

    @usableFromInline
    let ifNotExists: Bool

    @usableFromInline
    let schemaName: SchemaName?

    @usableFromInline
    let tableName: TableName

    @usableFromInline
    let moduleName: ModuleName

    @usableFromInline
    let moduleArguments: [String]

    @inlinable
    init(ifNotExists: Bool = true, schemaName: SchemaName? = nil, tableName: TableName, using moduleName: ModuleName) {
        self.init(ifNotExists: ifNotExists, schemaName: schemaName, tableName: tableName, using: moduleName, moduleArguments: [])
    }

    @inlinable
    init(ifNotExists: Bool = true, schemaName: SchemaName? = nil, tableName: TableName, using moduleName: ModuleName, @PassThroughBuilder<String> moduleArguments: () -> [String]) {
        self.init(ifNotExists: ifNotExists, schemaName: schemaName, tableName: tableName, using: moduleName, moduleArguments: moduleArguments())
    }

    @inlinable
    init(ifNotExists: Bool = true, schemaName: SchemaName? = nil, tableName: TableName, using moduleName: ModuleName, moduleArguments: [String]) {
        self.ifNotExists = ifNotExists
        self.schemaName = schemaName
        self.tableName = tableName
        self.moduleName = moduleName
        self.moduleArguments = moduleArguments
    }
}
