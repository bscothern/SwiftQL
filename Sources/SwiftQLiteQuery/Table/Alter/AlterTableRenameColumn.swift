//
//  AlterTableRenameColumn.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 1/30/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct AlterTableRenameColumn: Statement {
    @usableFromInline
    var statementValue: String { "\(base) RENAME COLUMN \(column) to \(newColumnName)" }

    @usableFromInline
    let base: AlterTableSubstatement

    @usableFromInline
    let column: ColumnName

    @usableFromInline
    let newColumnName: ColumnName

    @usableFromInline
    init(_ base: AlterTableSubstatement, column: ColumnName, newColumnName: ColumnName) {
        self.base = base
        self.column = column
        self.newColumnName = newColumnName
    }
}
