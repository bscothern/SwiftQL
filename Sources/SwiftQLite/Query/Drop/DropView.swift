//
//  DropView.swift
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

public struct DropView {
    @inlinable
    public var _statement: String { base.statementValue }

    @usableFromInline
    let base: DropStatementBase

    @inlinable
    public init(name: ViewName, ifExists: Bool = true) {
        base = .init(.view, name: name, schemaName: nil, ifExists: ifExists)
    }

    @inlinable
    public init(name: ViewName, schemaName: SchemaName, ifExists: Bool = true) {
        base = .init(.view, name: name, schemaName: schemaName, ifExists: ifExists)
    }
}
