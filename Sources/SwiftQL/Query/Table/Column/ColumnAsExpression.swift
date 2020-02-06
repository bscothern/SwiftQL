//
//  ColumnAsExpression.swift
//  SwiftQL
//
//  Created by Braden Scothern on 2/5/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLLinux
#else
import SQLite3
#endif

extension ColumnConstraint {
    public enum AsExpressionAttribute: String {
        case stored = "STORED"
        case virtual = "VIRTUAL"
    }
}

@usableFromInline
struct ColumnAsExpression: ColumnConstraintSubstatement {
    @usableFromInline
    var _substatement: String {
        let generatedAlways = self.generatedAlways ? " GENERATED ALWAYS" : ""
        let attribute = self.attribute.map { " \($0)" } ?? ""
        return "\(base._substatement)\(generatedAlways) AS (\(expression._substatement))\(attribute)"
    }
    
    @usableFromInline
    let generatedAlways: Bool
    
    @usableFromInline
    let expression: Expression
    
    @usableFromInline
    let attribute: ColumnConstraint.AsExpressionAttribute?

    @usableFromInline
    let base: ColumnConstraint

    @usableFromInline
    init(generatedAlways: Bool, expression: Expression, attribute: ColumnConstraint.AsExpressionAttribute?, appendedTo base: ColumnConstraint) {
        self.generatedAlways = generatedAlways
        self.expression = expression
        self.attribute = attribute
        self.base = base
    }
}
