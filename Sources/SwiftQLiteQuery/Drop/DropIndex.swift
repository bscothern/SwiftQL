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
    public var statementValue: String { base.statementValue }

    @usableFromInline
    let base: DropStatementBase

    @inlinable
    public init(name: IndexName, ifExists: Bool = true) {
        base = .init(.index, schemaName: nil, name: name, ifExists: ifExists)
    }

    @inlinable
    public init(schemaName: SchemaName, name: IndexName, ifExists: Bool = true) {
        base = .init(.index, schemaName: schemaName, name: name, ifExists: ifExists)
    }
}
