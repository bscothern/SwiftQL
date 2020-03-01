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
    public var _substatement: String {
        name.map { "CONSTRAINT \($0)" } ?? ""
    }

    @usableFromInline
    let name: String?

    @inlinable
    public init() {
        name = nil
    }

    @inlinable
    public init(name: String) {
        self.name = name
    }
}

extension ColumnConstraint {
    @inlinable
    public func primaryKey(ascending: Bool? = nil, onConflict: ConflictClause? = nil, autoIncrement: Bool = false) -> some ColumnConstraintSubstatement {
        PrimaryKey(ascending: ascending, onConflict: onConflict, autoIncrement: autoIncrement, appendedTo: self)
    }

    @inlinable
    public func notNull(onConflict: ConflictClause? = nil) -> some ColumnConstraintSubstatement {
        NotNull(onConflict: onConflict, appendedTo: self)
    }

    @inlinable
    public func unique(onConflict: ConflictClause?) -> some ColumnConstraintSubstatement {
        Unique(onConflict: onConflict, appendedTo: self)
    }

    @inlinable
    public func check(_ expression: Expression) -> some ColumnConstraintSubstatement {
        Check(expression, appendedTo: self)
    }

    @inlinable
    public func `default`<Numeral>(_ number: Numeral) -> some ColumnConstraintSubstatement where Numeral: SignedNumeric {
        Default(number, appendedTo: self)
    }

    @inlinable
    public func `default`(_ literal: Literal) -> some ColumnConstraintSubstatement {
        Default(literal, appendedTo: self)
    }

    @inlinable
    public func `default`(_ expression: Expression) -> some ColumnConstraintSubstatement {
        Default(expression, appendedTo: self)
    }

    @inlinable
    public func collate(_ function: CollateFunction) -> some ColumnConstraintSubstatement {
        Collate(function, appendedTo: self)
    }

    @inlinable
    public func foreignKeyClause(_ foreignKeyClause: ForeignKeyClause) -> some ColumnConstraintSubstatement {
        ColumnBoxForeignKeyClause(foreignKeyClause, appendedTo: self)
    }

    @inlinable
    public func generatedAlwaysAs(_ expression: Expression, attribute: AsExpressionAttribute? = nil) -> some ColumnConstraintSubstatement {
        ColumnAsExpression(generatedAlways: true, expression: expression, attribute: attribute, appendedTo: self)
    }

    @inlinable
    public func `as`(_ expression: Expression, attribute: AsExpressionAttribute? = nil) -> some ColumnConstraintSubstatement {
        ColumnAsExpression(generatedAlways: false, expression: expression, attribute: attribute, appendedTo: self)
    }
}
