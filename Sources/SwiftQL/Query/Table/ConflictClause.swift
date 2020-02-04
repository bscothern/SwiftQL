//
//  ConflictClause.swift
//  SwiftQL
//
//  Created by Braden Scothern on 1/30/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLLinux
#else
import SQLite3
#endif

/// https://sqlite.org/lang_conflict.html
public enum ConflictClause: String, _Substatement {
    case rollback = "ROLLBACK"
    case abort = "ABORT"
    case fail = "FAIL"
    case ignore = "IGNORE"
    case replace = "REPLACE"
    
    public var substatement: String { " ON CONFLICT \(rawValue)" }
}
