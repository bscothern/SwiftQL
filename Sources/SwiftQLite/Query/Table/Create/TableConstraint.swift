//
//  TableConstraint.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 2/3/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

public protocol TableConstraintSubstatement: Substatement {}

public struct TableConstraint: Substatement {
    @inlinable
    public var substatementValue: String {
        name.map { "CONSTRAINT \($0)" } ?? ""
    }

    @usableFromInline
    let name: String?

    @inlinable
    public init(name: String? = nil) {
        self.name = name
    }

    @inlinable
    public func primaryKey(indexedColumns: [String], onConflict: ConflictClause? = nil) -> some TableConstraintSubstatement {
        TableConstraintPrimaryKeyOrUnique(type: .primaryKey, indexedColumns: indexedColumns, onConflict: onConflict, appendingTo: self)
    }

    @inlinable
    public func unique(indexedColumns: [String], onConflict: ConflictClause? = nil) -> some TableConstraintSubstatement {
        TableConstraintPrimaryKeyOrUnique(type: .unique, indexedColumns: indexedColumns, onConflict: onConflict, appendingTo: self)
    }

    #warning("TODO")
    @inlinable
    public func check() -> some TableConstraintSubstatement {
        TableConstraintCheck(self)
    }

    @inlinable
    public func foreignKey(_ foreignKey: ForeignKeyClauseSubstatement, columns: [String]) -> some TableConstraintSubstatement {
        TableConstraintForeignKey(columns: columns, foreignKey: foreignKey, appendingTo: self)
    }
}

@usableFromInline
struct TableConstraintPrimaryKeyOrUnique: TableConstraintSubstatement {
    @usableFromInline
    enum Classification: String {
        case primaryKey = "PRIMARY KEY"
        case unique = "UNIQUE"
    }

    public var substatementValue: String {
        let classification = self.classification.rawValue
        let indexedColumns = self.indexedColumns.joined(separator: ", ")
        return "\(base) \(classification) (\(indexedColumns))\(onConflict, leadingSpace: true)"
    }

    @usableFromInline
    let classification: Classification

    @usableFromInline
    let indexedColumns: [String]

    @usableFromInline
    let onConflict: ConflictClause?

    @usableFromInline
    let base: TableConstraint

    @usableFromInline
    init(type classification: Classification, indexedColumns: [String], onConflict: ConflictClause?, appendingTo base: TableConstraint) {
        self.classification = classification
        self.indexedColumns = indexedColumns
        self.onConflict = onConflict
        self.base = base
    }
}

@usableFromInline
struct TableConstraintCheck: TableConstraintSubstatement {
    @inlinable
    public var substatementValue: String {
        let expression = ""
        return "\(base.substatementValue) CHECK (\(expression))"
    }

    @usableFromInline
    let base: TableConstraint

    @usableFromInline
    init(_ base: TableConstraint) {
        self.base = base
    }
}

@usableFromInline
struct TableConstraintForeignKey: TableConstraintSubstatement {
    @inlinable
    public var substatementValue: String {
        let columns = self.columns.joined(separator: ", ")
        return "\(base.substatementValue) FOREIGN KEY (\(columns)) \(foreignKey)"
    }

    @usableFromInline
    let columns: [String]

    @usableFromInline
    let foreignKey: ForeignKeyClauseSubstatement

    @usableFromInline
    let base: TableConstraint

    @usableFromInline
    init(columns: [String], foreignKey: ForeignKeyClauseSubstatement, appendingTo base: TableConstraint) {
        self.columns = columns
        self.foreignKey = foreignKey
        self.base = base
    }
}
