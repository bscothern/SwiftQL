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

/// Allows the creation of a table.
///
/// https://www.sqlite.org/lang_createtable.html
public struct CreateTable: Statement {
    @inlinable
    public var _statement: String {
        let isTemporary = self.isTemporary ? " TEMPORARY" : ""
        let ifNotExists = !self.ifNotExists ? " IF NOT EXISTS" : ""
        let schemaName = self.schemaName.map { "\($0)." } ?? ""
        let name = self.name
        return "CREATE\(isTemporary) TABLE\(ifNotExists) \(schemaName)\(name) \(content)"
    }

    @usableFromInline
    let name: String

    @usableFromInline
    let schemaName: String?

    @usableFromInline
    let isTemporary: Bool

    @usableFromInline
    let ifNotExists: Bool

    @usableFromInline
    let content: CreateTableContent

    @usableFromInline
    init(name: String, schemaName: String?, isTemporary: Bool = false, ifNotExists: Bool = true, content: CreateTableContent) {
        self.name = name
        self.schemaName = schemaName
        self.isTemporary = isTemporary
        self.ifNotExists = ifNotExists
        self.content = content
    }

    @inlinable
    public init(name: String, schemaName: String? = nil, isTemporary: Bool = false, ifNotExists: Bool = true, withoutRowID: Bool = false, @PassThroughBuilder<Column> columns columnBuilder: () -> [Column]) {
        //swiftlint:disable:previous attributes
        self.init(name: name, schemaName: schemaName, isTemporary: isTemporary, ifNotExists: ifNotExists, content: CreateTableWithColumnDefinitions(withoutRowID: withoutRowID, columns: columnBuilder(), constraints: []))
    }

    @inlinable
    public init(name: String, schemaName: String? = nil, isTemporary: Bool = false, ifNotExists: Bool = true, withoutRowID: Bool = false, @PassThroughBuilder<Column> columns columnBuilder: () -> [Column], @PassThroughBuilder<TableConstraintSubstatement> constraints constraintsBuilder: () -> [TableConstraintSubstatement]) {
        //swiftlint:disable:previous attributes
        self.init(name: name, schemaName: schemaName, isTemporary: isTemporary, ifNotExists: ifNotExists, content: CreateTableWithColumnDefinitions(withoutRowID: withoutRowID, columns: columnBuilder(), constraints: constraintsBuilder()))
    }

    @inlinable
    public init(name: String, schemaName: String? = nil, isTemporary: Bool = false, ifNotExists: Bool = true, as select: Select) {
        self.init(name: name, schemaName: schemaName, isTemporary: isTemporary, ifNotExists: ifNotExists, content: CreateTableAsSelectStatement(select))
    }
}

@usableFromInline
protocol CreateTableContent: Substatement {}

@usableFromInline
struct CreateTableWithColumnDefinitions: CreateTableContent {
    @usableFromInline
    let withoutRowID: Bool

    @usableFromInline
    let columns: [Column]

    @usableFromInline
    let constraints: [TableConstraintSubstatement]

    @usableFromInline
    var _substatement: String {
        let columns = self.columns.lazy
            .map { $0._substatement }
            .joined(separator: ", ")
        var constraints = self.constraints.lazy
            .map { $0._substatement }
            .joined(separator: ", ")
        if !constraints.isEmpty {
            constraints = ", \(constraints)"
        }
        let withoutRowID = self.withoutRowID ? " WITHOUT ROWID" : ""
        return "(\(columns)\(constraints))\(withoutRowID)"
    }

    @usableFromInline
    init(withoutRowID: Bool, columns columnBuilder: [Column], constraints: [TableConstraintSubstatement]) {
        self.withoutRowID = withoutRowID
        self.columns = columnBuilder
        self.constraints = constraints
    }
}

@usableFromInline
struct CreateTableAsSelectStatement: CreateTableContent {
    @usableFromInline
    var _substatement: String {
        "AS \(select)"
    }

    @usableFromInline
    let select: Select

    @usableFromInline
    init(_ select: Select) {
        self.select = select
    }
}
