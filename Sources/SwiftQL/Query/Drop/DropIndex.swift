//
//  DropIndex.swift
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

public struct DropIndex: Statement {
    @inlinable
    public var _statement: String { base._statement }

    @usableFromInline
    let base: DropStatementBase

    @inlinable
    public init(name: IndexName, ifExists: Bool = true) {
        base = .init(.index, name: name, schemaName: nil, ifExists: ifExists)
    }

    @inlinable
    public init(name: IndexName, schemaName: SchemaName, ifExists: Bool = true) {
        base = .init(.index, name: name, schemaName: schemaName, ifExists: ifExists)
    }
}
