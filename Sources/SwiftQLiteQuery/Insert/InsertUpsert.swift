//
//  InsertUpsert.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/2/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct InsertUpsert: InsertStatement {
    @usableFromInline
    enum UpsertAction: String {
        case nothing = "NOTHING"
        case update = "UPDATE SET"
    }

    @usableFromInline
    var statementValue: String { "\(base) DO \(action.rawValue)" }

    @usableFromInline
    let base: InsertOnConflictSubstatement

    @usableFromInline
    let action: UpsertAction

    @usableFromInline
    init(_ base: InsertOnConflictSubstatement, do action: UpsertAction) {
        self.base = base
        self.action = action
    }
}
