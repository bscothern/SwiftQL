//
//  ExpressionIs.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/22/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct ExpressionIs: ExpressionSubstatement {
    @usableFromInline
    enum Category: String {
        case `is` = "IS"
        case isNot = "IS NOT"
    }

    @usableFromInline
    var substatementValue: String { "\(expression) \(category.rawValue) \(other)" }

    @usableFromInline
    let expression: ExpressionSubstatement

    @usableFromInline
    let category: Category

    @usableFromInline
    let other: ExpressionSubstatement

    @usableFromInline
    init(_ expression: ExpressionSubstatement, category: Category, _ other: ExpressionSubstatement) {
        self.expression = expression
        self.category = category
        self.other = other
    }
}
