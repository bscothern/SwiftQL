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
public protocol ExpressionInSubstatement {}
public typealias ExpressionNotInSubstatement = ExpressionInSubstatement

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

    public enum UnaryPrefixOperator: String {
        case negative = "-"
        case positive = "+"
        case negated = "~"
        case not = "NOT"
    }

    public enum BinaryOperator: String {
        // These are grouped by order of precedence from highest to lowest

        case concatenate = "||"

        case multiply = "*"
        case divide = "/"
        case mod = "%"

        case bitShiftLeft = "<<"
        case bitShiftRight = ">>"
        case bitwiseAnd = "&"
        case bitwiseOr = "|"

        case lessThan = "<"
        case lessThanOrEqual = "<="
        case greaterThan = ">"
        case greaterThanOrEqual = ">="

        case assign = "="
        case equal = "=="
        case notEqual = "!="
        case notEqual2 = "<>"

        case `is` = "IS"
        case isNot = "IS NOT"
        case `in` = "IN"
        case like = "LIKE"
        case glob = "GLOB"
        case match = "MATCH"
        case regexp = "REGEXP"

        case and = "AND"

        case or = "OR"
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

    @inlinable
    @available(*, deprecated, message: "It is recomended to use prefix operators instead of this init")
    public init(prefixOperator: UnaryPrefixOperator, expression: Expression) {
        self.init(_prefixOperator: prefixOperator, expression: expression)
    }

    @usableFromInline
    init(_prefixOperator prefixOperator: UnaryPrefixOperator, expression: Expression) {
        base = ExpressionUnaryPrefixOperator(prefixOperator: prefixOperator, expression: expression)
    }

    @inlinable
    @available(*, deprecated, message: "It is recomended to use infix operators and functions instead of this init")
    public init(lhs: Expression, binaryOperator: BinaryOperator, rhs: Expression) {
        self.init(_lhs: lhs, binaryOperator: binaryOperator, rhs: rhs)
    }

    @usableFromInline
    init(_lhs lhs: Expression, binaryOperator: BinaryOperator, rhs: Expression) {
        base = ExpressionBinaryOperator(lhs: lhs, binaryOperator: binaryOperator, rhs: rhs)
    }

    // TODO: function-name

    @inlinable
    public init(@PassThroughBuilder<ExpressionSubstatement> list: () -> [ExpressionSubstatement]) {
        base = ExpressionList(list())
    }

    @inlinable
    public func cast(as typeName: TypeName) -> some ExpressionSubstatement {
        ExpressionCast(self, as: typeName)
    }

    // TODO: COLLATE

    // Should the pattern functions be broken down into their 8 cooresponding combos to help discoevability and consistancy with normal SQLite syntax?

    @inlinable
    public func patten(_ pattern: Pattern, _ other: ExpressionSubstatement) -> some ExpressionPattenSubstatement {
        ExpressionPattern(self, not: false, pattern: pattern, other: other)
    }

    @inlinable
    public func pattenNot(_ pattern: Pattern, _ other: ExpressionSubstatement) -> some ExpressionPattenSubstatement {
        ExpressionPattern(self, not: true, pattern: pattern, other: other)
    }

    @inlinable
    public func isNull() -> some ExpressionSubstatement {
        ExpressionNull(self, category: .isNull)
    }

    @inlinable
    public func notNull() -> some ExpressionSubstatement {
        ExpressionNull(self, category: .notNull)
    }

    @inlinable
    public func `is`(_ other: ExpressionSubstatement) -> some ExpressionSubstatement {
        ExpressionIs(self, category: .is, other)
    }

    @inlinable
    public func isNot(_ other: ExpressionSubstatement) -> some ExpressionSubstatement {
        ExpressionIs(self, category: .isNot, other)
    }

    @inlinable
    public func between(_ expression1: ExpressionSubstatement, _ expression2: ExpressionSubstatement) -> some ExpressionSubstatement {
        ExpressionBetween(self, category: .between, expression1, expression2)
    }

    @inlinable
    public func notBetween(_ expression1: ExpressionSubstatement, _ expression2: ExpressionSubstatement) -> some ExpressionSubstatement {
        ExpressionBetween(self, category: .notBetween, expression1, expression2)
    }

    @inlinable
    public func `in`() -> ExpressionInSubstatement {
        fatalError("TODO")
//        ExpressionIn(self, category: .in, condition: )
    }

    @inlinable
    public func notIn() -> ExpressionNotInSubstatement {
        fatalError("TODO")
//        ExpressionIn(self, category: .notIn, condition: )
    }

    // TODO: ((NOT) EXISTS) Select Statement

    // TODO: Case

    // TODO: raise-function
}

extension ExpressionPattenSubstatement {
    public func escape(_ expression: ExpressionSubstatement) -> some ExpressionSubstatement {
        ExpressionPatternEscape(self, expression)
    }
}
