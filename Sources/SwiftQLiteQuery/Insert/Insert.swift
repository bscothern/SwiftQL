//
//  Insert.swift
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

public protocol InsertStatement: TriggerTransaction {}
public protocol InsertSubstatement: Substatement {}
public protocol ColumnEditableInsert: InsertSubstatement {}
public protocol UpsertableInsert: InsertStatement {}
public protocol InsertOnConflictSubstatement: Substatement {}
public protocol InsertOnConflictWhereSubstatement: InsertOnConflictSubstatement {}

public struct Insert: ColumnEditableInsert {
    @inlinable
    public var substatementValue: String {
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
    public func columns(@PassThroughBuilder<ColumnName> names: () -> [ColumnName]) -> some InsertSubstatement {
        InsertColumns(self, names: names())
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
    public func values(@PassThroughBuilder<Expression> expressions: @escaping () -> [Expression]) -> some (InsertStatement & UpsertableInsert) {
        InsertValues(self, expressions: [.init(expressions())])
    }

    @inlinable
    public func values(@PassThroughBuilder<ExpressionGroup> expressions: @escaping () -> [ExpressionGroup]) -> some (InsertStatement & UpsertableInsert) {
        InsertValues(self, expressions: expressions())
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

extension InsertStatement where Self: UpsertableInsert {
    @inlinable
    public func onConflict() -> some InsertOnConflictSubstatement {
        InsertOnConflict(self, indexedColumns: [])
    }

    @inlinable
    public func onConflict(@PassThroughBuilder<IndexedColumnName> indexedColumns: () -> [IndexedColumnName]) -> some InsertOnConflictWhereSubstatement {
        InsertOnConflict(self, indexedColumns: indexedColumns())
    }
}

extension InsertOnConflictWhereSubstatement {
    @inlinable
    public func `where`(_ expression: Expression) -> some InsertOnConflictSubstatement {
        InsertOnConflictWhere(self, expression: expression)
    }
}

extension InsertOnConflictSubstatement {
    @inlinable
    public func doNothing() -> some InsertStatement {
        InsertUpsert(self, do: .nothing)
    }

    @inlinable public func update() -> some InsertStatement {
        InsertUpsert(self, do: .update)
    }
}
