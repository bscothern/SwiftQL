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

public struct NotNull: ColumnConstraint {
    @usableFromInline let onConflict: ConflictClause?

    @inlinable public var substatement: String {
        let onConflictStatement = onConflict?.substatement ?? ""
        return " NOT NULL\(onConflictStatement)"
    }

    @inlinable
    public init(onConflict: ConflictClause? = nil) {
        self.onConflict = onConflict
    }
}
