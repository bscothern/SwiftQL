//
//  SelectCoreSelectWhere.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/26/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

@usableFromInline
struct SelectCoreSelectWhere: SelectCoreSelectWhereExtendableStatement {
    @usableFromInline
    var statementValue: String { "\(base) WHERE \(expression)" }

    @usableFromInline
    let base: SelectCoreSelectFromExtendableStatement

    @usableFromInline
    let expression: Expression

    @usableFromInline
    init(_ base: SelectCoreSelectFromExtendableStatement, expression: Expression) {
        self.base = base
        self.expression = expression
    }
}
