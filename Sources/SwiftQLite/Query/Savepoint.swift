//
//  Savepoint.swift
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

public struct Savepoint: Statement {
    @inlinable
    public var _statement: String { "SAVEPOINT \(name)" }

    @usableFromInline
    let name: String

    @inlinable
    public init(name: String) {
        self.name = name
    }
}
