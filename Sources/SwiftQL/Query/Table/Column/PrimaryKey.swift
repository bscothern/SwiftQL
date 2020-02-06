//
//  PrimaryKey.swift
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
struct PrimaryKey: ColumnConstraintSubstatement {
    @usableFromInline
    var substatement: String {
        let ascendingStatement = ascending.map { $0 ? " ASC" : " DESC" } ?? ""
        let onConflictStatement = onConflict?.substatement ?? ""
        let autoIncrementStatement = autoIncrement ? " AUTOINCREMENT" : ""
        return "\(base.substatement) PRIMARY KEY\(ascendingStatement)\(onConflictStatement)\(autoIncrementStatement)"
    }

    @usableFromInline
    let ascending: Bool?
    
    @usableFromInline
    let onConflict: ConflictClause?
    
    @usableFromInline
    let autoIncrement: Bool
    
    @usableFromInline
    let base: ColumnConstraint

    @usableFromInline
    init(ascending: Bool?, onConflict: ConflictClause?, autoIncrement: Bool, appendedTo base: ColumnConstraint) {
        self.ascending = ascending
        self.onConflict = onConflict
        self.autoIncrement = autoIncrement
        self.base = base
    }
}
