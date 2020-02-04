//
//  Unique.swift
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

public struct Unique: ColumnConstraint {
    let onConflict: ConflictClause?
    
    public var substatement: String {
        let onConflictStatement = onConflict?.substatement ?? ""
        return " UNIQUE\(onConflictStatement)"
    }
    
    public init(onConflict: ConflictClause? = nil) {
        self.onConflict = onConflict
    }
}
