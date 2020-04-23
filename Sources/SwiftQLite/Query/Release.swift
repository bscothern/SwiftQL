//
//  Release.swift
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

public struct Release: Statement {
    @inlinable
    public var _statement: String { "RELEASE \(savepoint)" }

    @usableFromInline
    let savepoint: Savepoint

    @inlinable
    public init(_ savepoint: Savepoint) {
        self.savepoint = savepoint
    }
}
