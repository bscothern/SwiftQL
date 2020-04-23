//
//  DetachDatabase.swift
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

public struct DetachDatabase: Statement {
    @inlinable
    public var statementValue: String { "DETACH DATABASE\(schemaName.map { " \($0)" } ?? "")"}

    @usableFromInline
    let schemaName: SchemaName?

    @inlinable
    public init() {
        schemaName = nil
    }

    @inlinable
    public init(schemaName: SchemaName) {
        self.schemaName = schemaName
    }
}
