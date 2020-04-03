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
struct ColumnBoxForeignKeyClause: ColumnConstraintSubstatement {
    @usableFromInline
    var _substatement: String { "\(base) \(foreignKeyClause)" }

    @usableFromInline
    let foreignKeyClause: ForeignKeyClause

    @usableFromInline
    let base: ColumnConstraint

    @usableFromInline
    init(_ foreignKeyClause: ForeignKeyClause, appendedTo base: ColumnConstraint) {
        self.foreignKeyClause = foreignKeyClause
        self.base = base
    }
}
