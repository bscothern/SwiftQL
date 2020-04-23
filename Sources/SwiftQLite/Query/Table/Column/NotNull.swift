//
//  NotNull.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 2/3/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

@usableFromInline
struct NotNull: ColumnConstraintSubstatement {
    @usableFromInline
    var substatementValue: String {
        return "\(base) NOT NULL\(onConflict, leadingSpace: true)"
    }

    @usableFromInline
    let onConflict: ConflictClause?

    @usableFromInline
    let base: ColumnConstraint

    @usableFromInline
    init(onConflict: ConflictClause?, appendedTo base: ColumnConstraint) {
        self.onConflict = onConflict
        self.base = base
    }
}
