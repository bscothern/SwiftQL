//
//  ExpressionGroup.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/7/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct ExpressionGroup {
    public let expressions: [Expression]

    @inlinable
    public init(_ expressions: [Expression]) {
        assert(!expressions.isEmpty)
        self.expressions = expressions
    }

    @inlinable
    public init(@PassThroughBuilder<Expression> expressions: () -> [Expression]) {
        self.init(expressions())
    }
}
