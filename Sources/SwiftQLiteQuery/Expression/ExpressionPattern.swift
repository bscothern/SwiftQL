//
//  ExpressionPattern.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/24/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct ExpressionPattern: ExpressionPattenSubstatement {
    @usableFromInline
    var substatementValue: String { "\(expression)\(not ? " NOT" : "") \(pattern.rawValue) \(other)" }

    @usableFromInline
    let expression: ExpressionSubstatement

    @usableFromInline
    let not: Bool

    @usableFromInline
    let pattern: Expression.Pattern

    @usableFromInline
    let other: ExpressionSubstatement

    @usableFromInline
    init(_ expression: ExpressionSubstatement, not: Bool, pattern: Expression.Pattern, other: ExpressionSubstatement) {
        self.expression = expression
        self.not = not
        self.pattern = pattern
        self.other = other
    }
}
