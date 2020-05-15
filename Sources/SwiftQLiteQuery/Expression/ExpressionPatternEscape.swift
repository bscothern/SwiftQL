//
//  ExpressionPatternEscape.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/24/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct ExpressionPatternEscape: ExpressionSubstatement {
    @usableFromInline
    var substatementValue: String { "\(expression) ESCAPE \(escape)" }

    @usableFromInline
    let expression: ExpressionSubstatement

    @usableFromInline
    let escape: ExpressionSubstatement

    @usableFromInline
    init(_ expression: ExpressionSubstatement, _ escape: ExpressionSubstatement) {
        self.expression = expression
        self.escape = escape
    }
}
