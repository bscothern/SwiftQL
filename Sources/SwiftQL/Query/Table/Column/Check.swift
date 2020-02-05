//
//  Check.swift
//  SwiftQL
//
//  Created by Braden Scothern on 2/4/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLLinux
#else
import SQLite3
#endif

@usableFromInline
struct Check: ColumnConstraintSubstatement {
    @usableFromInline var substatement: String { "\(base.substatement) Check (\(expression.substatement))" }

    @usableFromInline let expression: Expression
    @usableFromInline let base: ColumnConstraint

    @usableFromInline
    init(_ expression: Expression, appendedTo base: ColumnConstraint) {
        self.expression = expression
        self.base = base
    }
}
