//
//  AttachDatabase.swift
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

public struct AttachDatabase: Statement {
    @inlinable
    public var statementValue: String { "ATTACH DATABASE \(expression) AS \(schemaName)" }

    @usableFromInline
    let expression: Expression

    @usableFromInline
    let schemaName: SchemaName

    @inlinable
    public init(_ expression: Expression, as schemaName: SchemaName) {
        self.expression = expression
        self.schemaName = schemaName
    }
}
