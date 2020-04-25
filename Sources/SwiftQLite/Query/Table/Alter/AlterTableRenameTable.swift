//
//  AlterTableRenameTable.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 1/30/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct AlterTableRenameTable: Statement {
    @usableFromInline
    var statementValue: String { "\(base) RENAME TO \(newTableName)" }
    
    @usableFromInline
    let base: AlterTableSubstatement
    
    @usableFromInline
    let newTableName: TableName
    
    @usableFromInline
    init(_ base: AlterTableSubstatement, newTableName: TableName) {
        self.base = base
        self.newTableName = newTableName
    }
}
