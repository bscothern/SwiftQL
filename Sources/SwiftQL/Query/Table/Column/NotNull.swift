//
//  NotNull.swift
//  SwiftQL
//
//  Created by Braden Scothern on 2/3/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLLinux
#else
import SQLite3
#endif

@usableFromInline
struct NotNull: ColumnConstraintSubstatement {
    @usableFromInline
    var _substatement: String {
        let onConflictStatement = onConflict?._spacedSubstatement ?? ""
        return "\(base._substatement) NOT NULL\(onConflictStatement)"
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
