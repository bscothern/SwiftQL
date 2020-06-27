//
//  File.swift
//  
//
//  Created by Braden Scothern on 6/22/20.
//

@usableFromInline
protocol ExpressionInCondition: Substatement {}

@usableFromInline
struct ExpressionIn: ExpressionInSubstatement {
    @usableFromInline
    enum Category: String {
        case `in` = "IN"
        case notIn = "NOT IN"
    }

    @usableFromInline
    var substatementValue: String { "\(expression) \(category) \(condition)" }

    @usableFromInline
    let expression: ExpressionSubstatement

    @usableFromInline
    let category: Category

    @usableFromInline
    let condition: ExpressionInCondition

    @usableFromInline
    init(_ expression: Expression, category: Category, condition: ExpressionInCondition) {
        self.expression = expression
        self.category = category
        self.condition = condition
    }
}
