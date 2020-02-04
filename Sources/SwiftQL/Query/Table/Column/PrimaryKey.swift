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

public struct PrimaryKey: ColumnConstraint {
    let ascending: Bool?
    let onConflict: ConflictClause?
    let autoIncrement: Bool
    
    public var substatement: String {
        let ascendingStatement = ascending.map { $0 ? " ASC" : " DESC" } ?? ""
        let onConflictStatement = onConflict?.substatement ?? ""
        let autoIncrementStatement = autoIncrement ? " AUTOINCREMENT" : ""
        return " PRIMARY KEY\(ascendingStatement)\(onConflictStatement)\(autoIncrementStatement)"
    }

    public init(ascending: Bool? = nil, onConflict: ConflictClause? = nil, autoIncrement: Bool = false) {
        self.ascending = ascending
        self.onConflict = onConflict
        self.autoIncrement = autoIncrement
    }
}
