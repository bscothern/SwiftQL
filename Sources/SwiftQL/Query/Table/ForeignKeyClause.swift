//
//  ForeignKeyClause.swift
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

// https://www.sqlite.org/syntax/foreign-key-clause.html

public protocol ForeignKeyClauseProtocol: _Substatement {}
public protocol ForeignKeyClauseExtendable: ForeignKeyClauseProtocol {}

public struct ForeignKeyClause: ForeignKeyClauseExtendable {
    public var substatement: String {
        let columnNames = self.columnNames.map { " (\($0.joined(separator: ", ")))" } ?? ""
        return " REFERENCES \(tableName)\(columnNames)"
    }
    
    @usableFromInline let tableName: String
    @usableFromInline let columnNames: [String]?
    
    public init(tableName: String, columnNames: [String]? = nil) {
        self.tableName = tableName
        self.columnNames = columnNames
    }
}

public extension ForeignKeyClauseExtendable {
    func onDelete(_ action: ForeignKeyClause.OnAction) -> some ForeignKeyClauseExtendable {
        ForeignKeyClauseOn(.delete, action: action, appendedTo: self)
    }
    
    func onUpdate(_ action: ForeignKeyClause.OnAction) -> some ForeignKeyClauseExtendable {
        ForeignKeyClauseOn(.update, action: action, appendedTo: self)
    }
    
    func match(_ name: String) -> some ForeignKeyClauseExtendable {
        ForeignKeyClauseMatch(name: name, appendedTo: self)
    }
    
    func notDeferrable() -> some ForeignKeyClauseProtocol {
        ForeignKeyClauseDeferrable(not: true, clause: nil, appendedTo: self)
    }
    
    func notDeferrable(_ clause: ForeignKeyClause.DeferrableClause) -> some ForeignKeyClauseProtocol {
        ForeignKeyClauseDeferrable(not: true, clause: clause, appendedTo: self)
    }
    
    func defferable() -> some ForeignKeyClauseProtocol {
        ForeignKeyClauseDeferrable(not: false, clause: nil, appendedTo: self)
    }
    
    func defferable(_ clause: ForeignKeyClause.DeferrableClause) -> some ForeignKeyClauseProtocol {
        ForeignKeyClauseDeferrable(not: false, clause: clause, appendedTo: self)
    }
}

public extension ForeignKeyClause {
    enum OnAction: String {
        case setNull = "SET NULL"
        case setDefault = "SET DEFAULT"
        case cascade = "CASCADE"
        case restrict = "RESTRICT"
        case noAction = "NO ACTION"
    }
}

@usableFromInline
struct ForeignKeyClauseOn: ForeignKeyClauseExtendable {
    @usableFromInline
    enum Category: String {
        case delete = "DELETE"
        case update = "UPDATE"
    }
    
    @usableFromInline var substatement: String {
        let category = self.category.rawValue
        let action = self.action.rawValue
        return "\(base.substatement) \(category) \(action)"
    }
    
    @usableFromInline let category: Category
    @usableFromInline let action: ForeignKeyClause.OnAction
    @usableFromInline let base: ForeignKeyClauseProtocol
    
    @usableFromInline
    init(_ category: Category, action: ForeignKeyClause.OnAction, appendedTo base: ForeignKeyClauseProtocol) {
        self.category = category
        self.action = action
        self.base = base
    }
}

@usableFromInline
struct ForeignKeyClauseMatch: ForeignKeyClauseExtendable {
    @usableFromInline var substatement: String {
        return "\(base.substatement) MATCH \(name)"
    }
    
    @usableFromInline let name: String
    @usableFromInline let base: ForeignKeyClauseProtocol
    
    @usableFromInline
    init(name: String, appendedTo base: ForeignKeyClauseExtendable) {
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
struct ForeignKeyClauseDeferrable: ForeignKeyClauseProtocol {
    @usableFromInline var substatement: String {
        let not = self.not ? " NOT" : ""
        let clause = self.clause.map { " \($0.rawValue)" } ?? ""
        return "\(base.substatement)\(not) DEFERRABLE\(clause)"
    }
    
    @usableFromInline let not: Bool
    @usableFromInline let clause: ForeignKeyClause.DeferrableClause?
    @usableFromInline let base: ForeignKeyClauseExtendable
    
    @usableFromInline
    init(not: Bool, clause: ForeignKeyClause.DeferrableClause?, appendedTo base: ForeignKeyClauseExtendable) {
        self.not = not
        self.clause = clause
        self.base = base
    }
}

