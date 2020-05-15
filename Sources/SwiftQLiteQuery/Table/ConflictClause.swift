//
//  ConflictClause.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 1/30/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

/// https://sqlite.org/lang_conflict.html
public enum ConflictClause: String, Substatement {
    case rollback = "ROLLBACK"
    case abort = "ABORT"
    case fail = "FAIL"
    case ignore = "IGNORE"
    case replace = "REPLACE"

    @inlinable
    public var substatementValue: String { "ON CONFLICT \(rawValue)" }
}
