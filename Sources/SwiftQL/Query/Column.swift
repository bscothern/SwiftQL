//
//  Column.swift
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

// TODO: Support Check
// TODO: Support Default
// TODO: Support Collate
// TODO: Support foreign-key-clause
// TODO: Support (Generated Always) As

/// https://www.sqlite.org/syntax/column-constraint.html
public protocol ColumnConstraint: Statement {}

/// https://www.sqlite.org/syntax/column-def.html
public struct Column {
    public let name: String
    public let type: DataType
    public let constraints: [ColumnConstraint]
    
    public init(name: String, type: DataType, constraints: [ColumnConstraint]) {
        self.name = name
        self.type = type
        self.constraints = constraints
    }
    
    public init(name: String, type: DataType, @PassThroughBuilder<ColumnConstraint> _ constraintsBuilder: () -> [ColumnConstraint]) {
        self.init(name: name, type: type, constraints: constraintsBuilder())
    }
}

// TODO: Move these out of this file

public struct PrimaryKey: ColumnConstraint {
    public let ascending: Bool?
    public let onConflict: ConflictClause?
    public let autoIncrement: Bool
    
    public var statement: String {
        let ascendingStatement = ascending.map { $0 ? " ASC" : " DESC" } ?? ""
        let onConflictStatement = onConflict.map { " \($0.statement)" } ?? ""
        let autoIncrementStatement = autoIncrement ? " AUTOINCREMENT" : ""
        return "PRIMARY KEY\(ascendingStatement)\(onConflictStatement)\(autoIncrementStatement)"
    }

    public init(ascending: Bool? = nil, onConflict: ConflictClause? = nil, autoIncrement: Bool = false) {
        self.ascending = ascending
        self.onConflict = onConflict
        self.autoIncrement = autoIncrement
    }
}

public struct NotNull: ColumnConstraint {
    public let onConflict: ConflictClause?
    
    public var statement: String {
        let onConflictStatement = onConflict.map { " \($0.statement)" } ?? ""
        return "NOT NULL\(onConflictStatement)"
    }
    
    public init(onConflict: ConflictClause? = nil) {
        self.onConflict = onConflict
    }
}

public struct Unique: ColumnConstraint {
    public let onConflict: ConflictClause?
    
    public var statement: String {
        let onConflictStatement = onConflict.map { " \($0.statement)" } ?? ""
        return "UNIQUE\(onConflictStatement)"
    }
    
    public init(onConflict: ConflictClause? = nil) {
        self.onConflict = onConflict
    }
}
