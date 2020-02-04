//
//  CreateTable.swift
//  SwiftQL
//
//  Created by Braden Scothern on 1/30/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLLinux
#else
import SQLite3
#endif

#warning("Support schema-name")
#warning("Support AS select-stmt")

/// Allows the creation of a table.
///
/// https://www.sqlite.org/lang_createtable.html
public struct CreateTable: Statement {
    public var statement: String {
        let isTemporary = !self.isTemporary ? "" : " TEMP"
        let ifNotExists = !self.ifNotExists ? "" : " IF NOT EXISTS"
        let schemaName = ""
        let name = " \(self.name)"
        return "CREATE\(isTemporary) TABLE\(ifNotExists)\(schemaName)\(name)\(base.substatement)"
    }
    
    @usableFromInline let name: String
    @usableFromInline let isTemporary: Bool
    @usableFromInline let ifNotExists: Bool
    @usableFromInline let base: _CreateTable
    
    @usableFromInline
    init(name: String, isTemporary: Bool, ifNotExists: Bool, base: _CreateTable) {
        self.name = name
        self.isTemporary = isTemporary
        self.ifNotExists = ifNotExists
        self.base = base
    }
    
    public init(name: String, isTemporary: Bool = false, ifNotExists: Bool, withoutRowID: Bool = false, @PassThroughBuilder<Column> columns columnBuilder: () -> [Column], constraints: [TableConstraintProtocol]) {
        self.init(name: name, isTemporary: isTemporary, ifNotExists: ifNotExists, base: CreateTableWithColumnDefinitions(withoutRowID: withoutRowID, columns: columnBuilder, constraints: constraints))
    }
    
    public init(name: String, isTemporary: Bool = false, ifNotExists: Bool, selectStatement: Void) {
        self.init(name: name, isTemporary: isTemporary, ifNotExists: ifNotExists, base: CreateTableAsSelectStatement())
    }
}

#warning("Move to other files")
@usableFromInline
protocol _CreateTable: _Substatement {}

@usableFromInline
struct CreateTableWithColumnDefinitions: _CreateTable {
    
    @usableFromInline let withoutRowID: Bool
    @usableFromInline let columns: [Column]
    @usableFromInline let constraints: [TableConstraintProtocol]
    
    @usableFromInline var substatement: String {
        let columns = self.columns.lazy
            .map { $0.substatement }
            .joined(separator: ", ")
        var constraints = self.constraints.lazy
            .map { $0.substatement }
            .joined(separator: ", ")
        if !constraints.isEmpty {
            constraints = ", \(constraints)"
        }
        let withoutRowID = !self.withoutRowID ? "" : " WITHOUT ROWID"
        return " (\(columns)\(constraints))\(withoutRowID)"
    }
    
    @usableFromInline
    init(withoutRowID: Bool, @PassThroughBuilder<Column> columns columnBuilder: () -> [Column], constraints: [TableConstraintProtocol]) {
        self.withoutRowID = withoutRowID
        self.columns = columnBuilder()
        self.constraints = constraints
    }
}

@usableFromInline
struct CreateTableAsSelectStatement: _CreateTable {
    @usableFromInline var substatement: String { "" }
}
