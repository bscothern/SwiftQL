//
//  Reindex.swift
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

/// https://www.sqlite.org/lang_reindex.html
public struct Reindex: Statement {
    @inlinable
    public var statementValue: String { "REINDEX\(_statementBase)" }

    @usableFromInline
    let _statementBase: String

    @inlinable
    public init() {
        _statementBase = ""
    }

    @inlinable
    public init(collationName: String) {
        _statementBase = " \(collationName)"
    }

    @inlinable
    public init(schemaName: SchemaName? = nil, tableName: TableName) {
        _statementBase = " \(schemaName.map { "\($0)." } ?? "")\(tableName)"
    }

    @inlinable
    public init(schemaName: SchemaName? = nil, indexName: IndexName) {
        _statementBase = " \(schemaName.map { "\($0)." } ?? "")\(indexName)"
    }
}
