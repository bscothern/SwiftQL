//
//  Insert.swift
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

public protocol InsertStatement: TriggerTransaction {}
public protocol InsertSubstatement: Substatement {}
public protocol ColumnEditableInsert: InsertSubstatement {}
public protocol UpsertableInsert: InsertStatement {}

public struct Insert: ColumnEditableInsert {
    @inlinable
    public var _substatement: String {
        "\(with, trailingSpace: true)"
    }

    @usableFromInline
    let with: With?

    @usableFromInline
    let or: Or?

    @usableFromInline
    let schemaName: SchemaName?

    @usableFromInline
    let tableName: TableName
    
    @usableFromInline
    let alias: TableName?

    @usableFromInline
    init(with: With?, or: Or?, schemaName: SchemaName?, tableName: TableName, as alias: TableName?) {
        self.with = with
        self.or = or
        self.schemaName = schemaName
        self.tableName = tableName
        self.alias = alias
    }

    @inlinable
    public init(or: Or? = nil, schemaName: SchemaName? = nil, tableName: TableName, as alias: TableName? = nil) {
        self.init(with: nil, or: or, schemaName: schemaName, tableName: tableName, as: alias)
    }
}

extension ColumnEditableInsert {
    @inlinable
    public func columns() -> some InsertSubstatement {
        InsertColumns(self)
    }
}

extension With {
    @inlinable
    public func insert(or: Or? = nil, schemaName: SchemaName? = nil, tableName: TableName, as alias: TableName? = nil) -> Insert {
        .init(with: self, or: or, schemaName: schemaName, tableName: tableName, as: alias)
    }
}

extension InsertSubstatement {
    @inlinable
    public func values() -> some (InsertStatement & UpsertableInsert) {
        InsertValues(self)
    }
    
    @inlinable
    public func select(_ select: Select) -> some (InsertStatement & UpsertableInsert) {
        InsertSelect(self, select: select)
    }
    
    @inlinable
    public func defaultValues() -> some (InsertStatement & UpsertableInsert) {
        InsertDefaultValues(self)
    }
}

extension InsertStatement where Self: UpsertableInsert  {
    public func upsert(_ upsert: Upsert) -> some InsertStatement {
        InsertUpsert(self, upsert: upsert)
    }
}
