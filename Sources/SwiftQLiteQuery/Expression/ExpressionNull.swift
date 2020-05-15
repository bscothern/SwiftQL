//
//  ExpressionIs.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/24/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct ExpressionNull: ExpressionSubstatement {
    @usableFromInline
    enum Category: String {
        case isNull = "ISNULL"
        case notNull = "NOT NULL"
    }

    @usableFromInline
    var substatementValue: String { "\(expression) \(category.rawValue)" }

    @usableFromInline
    let expression: ExpressionSubstatement

    @usableFromInline
    let category: Category

    @usableFromInline
    init(_ expression: ExpressionSubstatement, category: Category) {
        self.expression = expression
        self.category = category
    }
}
