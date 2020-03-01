//
//  DetachDatabase.swift
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

public struct DetachDatabase: Statement {
    @inlinable
    public var _statement: String { "DETACH DATABASE\(schemaName.map { " \($0)" } ?? "")"}

    @usableFromInline
    let schemaName: String?

    @inlinable
    public init() {
        schemaName = nil
    }

    @inlinable
    public init(schemaName: String) {
        self.schemaName = schemaName
    }
}
