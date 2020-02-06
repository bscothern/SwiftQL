//
//  ColumnConstraint.swift
//  SwiftQL
//
//  Created by Braden Scothern on 2/3/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLLinux
#else
import SQLite3
#endif

/// https://www.sqlite.org/syntax/column-constraint.html
public protocol ColumnConstraintSubstatement: Substatement {}

public struct ColumnConstraint: Substatement {
    @inlinable
    public var substatement: String {
        name.map { "CONSTRAINT \($0)" } ?? ""
    }

    @usableFromInline
    let name: String?

    public init(name: String? = nil) {
        self.name = name
    }
}

extension ColumnConstraint {
    @inlinable
    public func primaryKey(ascending: Bool? = nil, onConflict: ConflictClause? = nil, autoIncrement: Bool = false) -> some ColumnConstraintSubstatement {
        PrimaryKey(ascending: ascending, onConflict: onConflict, autoIncrement: autoIncrement, appendedTo: self)
    }

    @inlinable
    public static func primaryKey(ascending: Bool? = nil, onConflict: ConflictClause? = nil, autoIncrement: Bool = false) -> some ColumnConstraintSubstatement {
        Self().primaryKey(ascending: ascending, onConflict: onConflict, autoIncrement: autoIncrement)
    }

    @inlinable
    public func notNull(onConflict: ConflictClause? = nil) -> some ColumnConstraintSubstatement {
        NotNull(onConflict: onConflict, appendedTo: self)
    }

    @inlinable
    public static func notNull(onConflict: ConflictClause? = nil) -> some ColumnConstraintSubstatement {
        Self().notNull(onConflict: onConflict)
    }

    @inlinable
    public func unique(onConflict: ConflictClause?) -> some ColumnConstraintSubstatement {
        Unique(onConflict: onConflict, appendedTo: self)
    }

    @inlinable
    public static func unique(onConflict: ConflictClause?) -> some ColumnConstraintSubstatement {
        Self().unique(onConflict: onConflict)
    }

    @inlinable
    public func check(_ expression: Expression) -> some ColumnConstraintSubstatement {
        Check(expression, appendedTo: self)
    }

    @inlinable
    public static func check(_ expression: Expression) -> some ColumnConstraintSubstatement {
        Self().check(expression)
    }

    @inlinable
    public func `default`<Numeral>(_ number: Numeral) -> some ColumnConstraintSubstatement where Numeral: SignedNumeric {
        Default(number, appendedTo: self)
    }

    @inlinable
    public static func `default`<Numeral>(_ number: Numeral) -> some ColumnConstraintSubstatement where Numeral: SignedNumeric {
        Self().default(number)
    }

    @inlinable
    public func `default`(_ literal: Literal) -> some ColumnConstraintSubstatement {
        Default(literal, appendedTo: self)
    }

    @inlinable
    public static func `default`(_ literal: Literal) -> some ColumnConstraintSubstatement {
        Self().default(literal)
    }

    @inlinable
    public func `default`(_ expression: Expression) -> some ColumnConstraintSubstatement {
        Default(expression, appendedTo: self)
    }

    @inlinable
    public static func `default`(_ expression: Expression) -> some ColumnConstraintSubstatement {
        Self().default(expression)
    }

    @inlinable
    public func collate(_ function: CollateFunction) -> some ColumnConstraintSubstatement {
        Collate(function, appendedTo: self)
    }

    @inlinable
    public static func collate(_ function: CollateFunction) -> some ColumnConstraintSubstatement {
        Self().collate(function)
    }

    @inlinable
    public func foreignKeyClause(_ foreignKeyClause: ForeignKeyClause) -> some ColumnConstraintSubstatement {
        ColumnBoxForeignKeyClause(foreignKeyClause, appendedTo: self)
    }

    @inlinable
    public static func foreignKeyClause(_ foreignKeyClause: ForeignKeyClause) -> some ColumnConstraintSubstatement {
        Self().foreignKeyClause(foreignKeyClause)
    }
    
    @inlinable
    public func generatedAlwaysAs(_ expression: Expression, attribute: AsExpressionAttribute? = nil) -> some ColumnConstraintSubstatement {
        ColumnAsExpression(generatedAlways: true, expression: expression, attribute: attribute, appendedTo: self)
    }

    @inlinable
    public static func generatedAlwaysAs(_ expression: Expression, attribute: AsExpressionAttribute? = nil) -> some ColumnConstraintSubstatement {
        Self().generatedAlwaysAs(expression, attribute: attribute)
    }

    @inlinable
    public func `as`(_ expression: Expression, attribute: AsExpressionAttribute? = nil) -> some ColumnConstraintSubstatement {
        ColumnAsExpression(generatedAlways: false, expression: expression, attribute: attribute, appendedTo: self)
    }

    @inlinable
    public static func `as`(_ expression: Expression, attribute: AsExpressionAttribute? = nil) -> some ColumnConstraintSubstatement {
        Self().as(expression, attribute: attribute)
    }
}
