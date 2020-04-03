//
//  Insert.swift
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

public protocol InsertStatement: Statement {}

extension With {
//    public func insert
}

public struct Insert: Statement {
    @inlinable
    public var _statement: String {
        ""
    }

    @usableFromInline
    let with: With?

    @usableFromInline
    let or: Or?

    @usableFromInline
    let schemaName: SchemaName?

    @usableFromInline
    let tableName: TableName

//    @usableFromInline
//    init(with: With?, or: Or?, schemaName: SchemaName?, tableName: TableName) {
//        self.with = with
//        self.or = or
//    }
//
//    @inlinable
//    public init(or: Or? = nil, schemaName: SchemaName? = nil, tableName: TableName) {
//        self.init(with: nil, or: or, schemaName: schemaName, tableName: tableName)
//    }
}
