//
//  AlterTableAddColumn.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 1/30/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct AlterTableAddColumn: Statement {
    @usableFromInline
    var statementValue: String { "\(base) ADD COLUMN \(column)" }

    @usableFromInline
    let base: AlterTableSubstatement

    @usableFromInline
    let column: Column

    @usableFromInline
    init(_ base: AlterTableSubstatement, column: Column) {
        self.base = base
        self.column = column
    }
}
