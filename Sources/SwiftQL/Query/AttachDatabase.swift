//
//  AttachDatabase.swift
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

public struct AttachDatabase: Statement {
    @inlinable
    public var _statement: String { "ATTACH DATABASE \(expression) AS \(schemaName)" }

    @usableFromInline
    let expression: Expression

    @usableFromInline
    let schemaName: String

    @inlinable
    public init(_ expression: Expression, as schemaName: String) {
        self.expression = expression
        self.schemaName = schemaName
    }
}
