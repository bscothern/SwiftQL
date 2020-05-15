//
//  Expression.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 2/4/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

public protocol ExpressionSubstatement: Substatement {}
public protocol ExpressionPattenSubstatement: ExpressionSubstatement {}

#warning("IMPLIMENT")
/// https://www.sqlite.org/lang_expr.html
public struct Expression: ExpressionSubstatement {
    public enum TypeName: String {
        case none = "NONE"
        case text = "TEXT"
        case real = "REAL"
        case integer = "INTEGER"
        case numeric = "NUMERIC"
    }

    public enum Pattern: String {
        case like = "LIKE"
        case glob = "GLOB"
        case regexp = "REGEXP"
        case match = "MATCH"
    }

    @inlinable
    public var substatementValue: String { "\(base)" }

    @usableFromInline
    let base: ExpressionSubstatement

    @inlinable
    public init(literal: Literal) {
        base = ExpressionLiteral(literal)
    }

    // TODO: Bind parameter

    @inlinable
    public init(columnName: ColumnName) {
        base = ExpressionSchemaTableColumnName(schemaName: nil, tableName: nil, columnName: columnName)
    }

    @inlinable
    public init(tableName: TableName, columnName: ColumnName) {
        base = ExpressionSchemaTableColumnName(schemaName: nil, tableName: tableName, columnName: columnName)
    }

    @inlinable
    public init(schemaName: SchemaName, tableName: TableName, columnName: ColumnName) {
        base = ExpressionSchemaTableColumnName(schemaName: schemaName, tableName: tableName, columnName: columnName)
    }

    // TODO: Unary-operator

    // TODO: binary operator

    // TODO: function-name

    @inlinable
    public init(@PassThroughBuilder<ExpressionSubstatement> list: () -> [ExpressionSubstatement]) {
        base = ExpressionList(list())
    }

    @inlinable
    public func cast(as typeName: TypeName) -> ExpressionSubstatement {
        ExpressionCast(self, as: typeName)
    }

    // TODO: COLLATE

    // Should the pattern functions be broken down into their 8 cooresponding combos to help discoevability and consistancy with normal SQLite syntax?

    @inlinable
    public func patten(_ pattern: Pattern, _ other: ExpressionSubstatement) -> ExpressionPattenSubstatement {
        ExpressionPattern(self, not: false, pattern: pattern, other: other)
    }

    @inlinable
    public func pattenNot(_ pattern: Pattern, _ other: ExpressionSubstatement) -> ExpressionPattenSubstatement {
        ExpressionPattern(self, not: true, pattern: pattern, other: other)
    }

    @inlinable
    public func isNull() -> ExpressionSubstatement {
        ExpressionNull(self, category: .isNull)
    }

    @inlinable
    public func notNull() -> ExpressionSubstatement {
        ExpressionNull(self, category: .notNull)
    }

    @inlinable
    public func `is`(_ other: ExpressionSubstatement) -> ExpressionSubstatement {
        ExpressionIs(self, category: .is, other)
    }

    @inlinable
    public func isNot(_ other: ExpressionSubstatement) -> ExpressionSubstatement {
        ExpressionIs(self, category: .isNot, other)
    }

    @inlinable
    public func between(_ expression1: ExpressionSubstatement, _ expression2: ExpressionSubstatement) -> ExpressionSubstatement {
        ExpressionBetween(self, category: .between, expression1, expression2)
    }

    @inlinable
    public func notBetween(_ expression1: ExpressionSubstatement, _ expression2: ExpressionSubstatement) -> ExpressionSubstatement {
        ExpressionBetween(self, category: .notBetween, expression1, expression2)
    }

    // TODO: (NOT) In

    // TODO: ((NOT) EXISTS) Select Statement

    // TODO: Case

    // TODO: raise-function
}

extension ExpressionPattenSubstatement {
    public func escape(_ expression: ExpressionSubstatement) -> ExpressionSubstatement {
        ExpressionPatternEscape(self, expression)
    }
}
