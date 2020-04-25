//
//  Explain.swift
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

/// https://www.sqlite.org/lang_explain.html
public struct Explain: Statement {
    @inlinable
    public var statementValue: String { "EXPLAIN\(statement.map { " \($0)" } ?? "")" }
    
    @usableFromInline
    let statement: Statement?
    
    public init() {
        statement = nil
    }
    
    public init(_ statement: Statement) {
        if let explain = statement as? Explain {
            self = explain
        } else {
            self.statement = statement
        }
    }
}
