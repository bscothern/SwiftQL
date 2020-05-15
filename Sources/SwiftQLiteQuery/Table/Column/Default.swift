//
//  Default.swift
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

@usableFromInline
struct Default: ColumnConstraintSubstatement {
    @usableFromInline
    var substatementValue: String { "\(base) DEFAULT \(content)" }

    @usableFromInline
    let content: DefaultContent

    @usableFromInline
    let base: ColumnConstraint

    @usableFromInline
    init<Numeral>(_ number: Numeral, appendedTo base: ColumnConstraint) where Numeral: SignedNumeric {
        self.content = DefaultSignedNumber(number)
        self.base = base
    }

    @usableFromInline
    init(_ literal: Literal, appendedTo base: ColumnConstraint) {
        self.content = DefaultLiteral(literal)
        self.base = base
    }

    @usableFromInline
    init(_ expression: Expression, appendedTo base: ColumnConstraint) {
        self.content = DefaultExpression(expression)
        self.base = base
    }
}

@usableFromInline
protocol DefaultContent: Substatement {}

@usableFromInline
struct DefaultExpression: DefaultContent {
    @inlinable
    public var substatementValue: String { "(\(expression))" }

    @usableFromInline
    let expression: Expression

    @usableFromInline
    init(_ expression: Expression) {
        self.expression = expression
    }
}

@usableFromInline
struct DefaultSignedNumber<Numeral>: DefaultContent where Numeral: SignedNumeric {
    @inlinable
    public var substatementValue: String { "\(number)" }

    @usableFromInline
    let number: Numeral

    @usableFromInline
    init(_ number: Numeral) {
        self.number = number
    }
}

@usableFromInline
struct DefaultLiteral: DefaultContent {
    @inlinable
    public var substatementValue: String { literal.substatementValue }

    @usableFromInline
    let literal: Literal

    @usableFromInline
    init(_ literal: Literal) {
        self.literal = literal
    }
}
