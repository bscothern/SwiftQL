//
//  ExpressionUnaryPrefixOperator.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 5/14/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct ExpressionUnaryPrefixOperator: ExpressionSubstatement {
    @usableFromInline
    var substatementValue: String { "\(prefixOperator.rawValue) \(expression)" }
    
    @usableFromInline
    let prefixOperator: Expression.UnaryPrefixOperator

    @usableFromInline
    let expression: Expression

    @usableFromInline
    init(prefixOperator: Expression.UnaryPrefixOperator, expression: Expression) {
        self.prefixOperator = prefixOperator
        self.expression = expression
    }
}

//MARK: Unary Prefix Operators
@inlinable
public prefix func + (expression: Expression) -> Expression {
    .init(_prefixOperator: .positive, expression: expression)
}

@inlinable
public prefix func - (expression: Expression) -> Expression {
    .init(_prefixOperator: .negative, expression: expression)
}

@inlinable
public prefix func ~ (expression: Expression) -> Expression {
    .init(_prefixOperator: .negated, expression: expression)
}

@inlinable
public prefix func ! (expression: Expression) -> Expression {
    .init(_prefixOperator: .not, expression: expression)
}

@inlinable
@available(*, deprecated, message: "Use prefix operator ! to NOT an expression")
public func not(_ expression: Expression) -> Expression {
    !expression
}
