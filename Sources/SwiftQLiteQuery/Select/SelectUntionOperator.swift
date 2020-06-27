//
//  SelectUntionOperator.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 6/23/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct SelectUnionOperator: SelectStatement {
    @usableFromInline
    enum Operator: String {
        case union = "UNION"
        case unionAll = "UNION ALL"
        case interset = "INTERSECT"
        case except = "EXCEPT"
    }

    @usableFromInline
    var statementValue: String { "\(base) \(`operator`.rawValue) \(select)" }

    @usableFromInline
    let base: SelectStatement

    @usableFromInline
    let `operator`: Operator

    @usableFromInline
    let select: SelectStatement

    @usableFromInline
    init(_ base: SelectStatement, operator: Operator, with select: SelectStatement) {
        self.base = base
        self.operator = `operator`
        self.select = select
    }
}
