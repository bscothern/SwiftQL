//
//  SelectLimit.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 6/23/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct SelectLimit: SelectStatement {
    @usableFromInline
    var statementValue: String {
        let offsetOrComma: String
        if offset {
            offsetOrComma = " OFFSET"
        } else if expression2 != nil {
            offsetOrComma = ", "
        } else {
            offsetOrComma = ""
        }
        let expression2 = self.expression2.map { " \($0.substatementValue)" } ?? ""
        return "\(base) LIMIT \(expression)\(offsetOrComma)\(expression2)"
    }

    @usableFromInline
    let base: SelectStatement

    @usableFromInline
    let expression: Expression

    @usableFromInline
    let offset: Bool

    @usableFromInline
    let expression2: Expression?

    @usableFromInline
    init(_ base: SelectStatement, expression: Expression, offset: Bool, expression2: Expression?) {
        self.base = base
        self.expression = expression
        self.offset = offset
        self.expression2 = expression2
    }
}
