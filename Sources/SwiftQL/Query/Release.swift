//
//  Release.swift
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

public struct Release: Statement {
    @inlinable
    public var _statement: String { "RELEASE \(savepoint._statement)" }

    @usableFromInline
    let savepoint: Savepoint

    @inlinable
    public init(_ savepoint: Savepoint) {
        self.savepoint = savepoint
    }
}
