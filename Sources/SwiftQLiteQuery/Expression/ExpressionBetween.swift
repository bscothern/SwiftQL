//
//  ExpressionIs.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/24/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct ExpressionBetween: ExpressionSubstatement {
    @usableFromInline
    enum Category: String {
        case between = "BETWEEN"
        case notBetween = "NOT BETWEEN"
    }

    @usableFromInline
    var substatementValue: String { "\(expression) \(category.rawValue) \(expression1) AND \(expression2)" }

    @usableFromInline
    let expression: ExpressionSubstatement

    @usableFromInline
    let category: Category

    @usableFromInline
    let expression1: ExpressionSubstatement

    @usableFromInline
    let expression2: ExpressionSubstatement

    @usableFromInline
    init(_ expression: ExpressionSubstatement, category: Category, _ expression1: ExpressionSubstatement, _ expression2: ExpressionSubstatement) {
        self.expression = expression
        self.category = category
        self.expression1 = expression1
        self.expression2 = expression2
    }
}
