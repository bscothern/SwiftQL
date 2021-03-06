//
//  Check.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 2/4/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

@usableFromInline
struct Check: ColumnConstraintSubstatement {
    @usableFromInline
    var substatementValue: String { "\(base.substatementValue) Check (\(expression))" }

    @usableFromInline
    let expression: Expression

    @usableFromInline
    let base: ColumnConstraint

    @usableFromInline
    init(_ expression: Expression, appendedTo base: ColumnConstraint) {
        self.expression = expression
        self.base = base
    }
}
