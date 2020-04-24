//
//  ExpressionCast.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/24/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct ExpressionCast: ExpressionSubstatement {
    @usableFromInline
    enum Category: String {
        case between = "BETWEEN"
        case notBetween = "NOT BETWEEN"
    }

    @usableFromInline
    var substatementValue: String { "CAST (\(expression) AS \(typeName.rawValue)" }

    @usableFromInline
    let expression: ExpressionSubstatement

    @usableFromInline
    let typeName: Expression.TypeName

    @usableFromInline
    init(_ expression: ExpressionSubstatement, as typeName: Expression.TypeName) {
        self.expression = expression
        self.typeName = typeName
    }
}
