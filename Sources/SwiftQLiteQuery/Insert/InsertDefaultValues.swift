//
//  InsertDefaultValues.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/2/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct InsertDefaultValues: InsertStatement, UpsertableInsert {
    @usableFromInline
    var statementValue: String { "\(base) DEFAULT VALUES" }

    @usableFromInline
    let base: InsertSubstatement

    @usableFromInline
    init(_ base: InsertSubstatement) {
        self.base = base
    }
}
