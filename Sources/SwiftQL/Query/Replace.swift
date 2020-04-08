//
//  Replace.swift
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

public struct Replace: ColumnEditableInsert {
    @inlinable
    public var _substatement: String {
        "\(insert)"
    }

    @usableFromInline
    let insert: Insert

    @usableFromInline
    init(insert: Insert) {
        self.insert = insert
    }

    @inlinable
    public init(schemaName: SchemaName? = nil, tableName: TableName, as alias: TableName? = nil) {
        self.init(insert: .init(with: nil, or: .replace, schemaName: schemaName, tableName: tableName, as: alias))
    }
}

extension With {
    @inlinable
    public func replace(schemaName: SchemaName? = nil, tableName: TableName, as alias: TableName? = nil) -> Replace {
        .init(insert: .init(with: self, or: .replace, schemaName: schemaName, tableName: tableName, as: alias))
    }
}
