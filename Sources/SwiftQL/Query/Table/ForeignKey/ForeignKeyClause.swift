//
//  ForeignKeyClause.swift
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

// https://www.sqlite.org/syntax/foreign-key-clause.html

public protocol ForeignKeyClauseSubstatement: Substatement {}
public protocol ForeignKeyClauseSubstatementExtendable: ForeignKeyClauseSubstatement {}

public struct ForeignKeyClause: ForeignKeyClauseSubstatementExtendable {
    @inlinable
    public var _substatement: String {
        let columnNames = self.columnNames.map { " (\($0.joined(separator: ", ")))" } ?? ""
        return "REFERENCES \(tableName)\(columnNames)"
    }

    @usableFromInline
    let tableName: TableName

    @usableFromInline
    let columnNames: [String]?

    public init(tableName: TableName, columnNames: [String]? = nil) {
        self.tableName = tableName
        self.columnNames = columnNames
    }
}

extension ForeignKeyClauseSubstatementExtendable {
    @inlinable
    public func onDelete(_ action: ForeignKeyClause.OnAction) -> some ForeignKeyClauseSubstatementExtendable {
        ForeignKeyClauseOn(.delete, action: action, appendedTo: self)
    }

    @inlinable
    public func onUpdate(_ action: ForeignKeyClause.OnAction) -> some ForeignKeyClauseSubstatementExtendable {
        ForeignKeyClauseOn(.update, action: action, appendedTo: self)
    }

    @inlinable
    public func match(_ name: String) -> some ForeignKeyClauseSubstatementExtendable {
        ForeignKeyClauseMatch(name: name, appendedTo: self)
    }

    @inlinable
    public func notDeferrable() -> some ForeignKeyClauseSubstatement {
        ForeignKeyClauseDeferrable(not: true, clause: nil, appendedTo: self)
    }

    @inlinable
    public func notDeferrable(_ clause: ForeignKeyClause.DeferrableClause) -> some ForeignKeyClauseSubstatement {
        ForeignKeyClauseDeferrable(not: true, clause: clause, appendedTo: self)
    }

    @inlinable
    public func defferable() -> some ForeignKeyClauseSubstatement {
        ForeignKeyClauseDeferrable(not: false, clause: nil, appendedTo: self)
    }

    @inlinable
    public func defferable(_ clause: ForeignKeyClause.DeferrableClause) -> some ForeignKeyClauseSubstatement {
        ForeignKeyClauseDeferrable(not: false, clause: clause, appendedTo: self)
    }
}

extension ForeignKeyClause {
    public enum OnAction: String {
        case setNull = "SET NULL"
        case setDefault = "SET DEFAULT"
        case cascade = "CASCADE"
        case restrict = "RESTRICT"
        case noAction = "NO ACTION"
    }
}

@usableFromInline
struct ForeignKeyClauseOn: ForeignKeyClauseSubstatementExtendable {
    @usableFromInline
    enum Category: String {
        case delete = "DELETE"
        case update = "UPDATE"
    }

    @usableFromInline var _substatement: String {
        let category = self.category.rawValue
        let action = self.action.rawValue
        return "\(base) \(category) \(action)"
    }

    @usableFromInline
    let category: Category

    @usableFromInline
    let action: ForeignKeyClause.OnAction

    @usableFromInline
    let base: ForeignKeyClauseSubstatement

    @usableFromInline
    init(_ category: Category, action: ForeignKeyClause.OnAction, appendedTo base: ForeignKeyClauseSubstatement) {
        self.category = category
        self.action = action
        self.base = base
    }
}

@usableFromInline
struct ForeignKeyClauseMatch: ForeignKeyClauseSubstatementExtendable {
    @usableFromInline var _substatement: String {
        return "\(base) MATCH \(name)"
    }

    @usableFromInline
    let name: String

    @usableFromInline
    let base: ForeignKeyClauseSubstatement

    @usableFromInline
    init(name: String, appendedTo base: ForeignKeyClauseSubstatementExtendable) {
        self.name = name
        self.base = base
    }
}

public extension ForeignKeyClause {
    enum DeferrableClause: String {
        case initiallyDeferred = "INITIALLY DEFERRED"
        case initiallyImmediate = "INITIALLY IMMEDIATE"
    }
}

@usableFromInline
struct ForeignKeyClauseDeferrable: ForeignKeyClauseSubstatement {
    @usableFromInline
    var _substatement: String {
        let not = self.not ? " NOT" : ""
        let clause = self.clause.map { " \($0.rawValue)" } ?? ""
        return "\(base)\(not) DEFERRABLE\(clause)"
    }

    @usableFromInline
    let not: Bool

    @usableFromInline
    let clause: ForeignKeyClause.DeferrableClause?

    @usableFromInline
    let base: ForeignKeyClauseSubstatementExtendable

    @usableFromInline
    init(not: Bool, clause: ForeignKeyClause.DeferrableClause?, appendedTo base: ForeignKeyClauseSubstatementExtendable) {
        self.not = not
        self.clause = clause
        self.base = base
    }
}
