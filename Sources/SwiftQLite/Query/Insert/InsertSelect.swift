//
//  InsertSelect.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/2/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct InsertSelect: InsertStatement, UpsertableInsert {
    @usableFromInline
    var statementValue: String { "\(base) \(select)" }

    @usableFromInline
    let base: InsertSubstatement

    @usableFromInline
    let select: Select

    @usableFromInline
    init(_ base: InsertSubstatement, select: Select) {
        self.base = base
        self.select = select
    }
}
