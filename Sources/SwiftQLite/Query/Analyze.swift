//
//  Analyze.swift
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

/// https://www.sqlite.org/lang_analyze.html
public struct Analyze: Statement {
    @inlinable
    public var statementValue: String {
        "ANALYZE \(substatement.substatementValue)"
    }

    @usableFromInline
    let substatement: _AnalyzeSubstatement

    @inlinable
    public init(schemaName: SchemaName) {
        substatement = _SchemaName(schemaName)
    }

    @inlinable
    public init(tableName: TableName) {
        substatement = _TableOrIndexName(tableName)
    }

    @inlinable
    public init(indexName: IndexName) {
        substatement = _TableOrIndexName(indexName)
    }

    @inlinable
    public init(schemaName: SchemaName, tableName: TableName) {
        substatement = _SchemaName(schemaName, tableOrIndexName: _TableOrIndexName(tableName))
    }

    @inlinable
    public init(schemaName: SchemaName, indexName: IndexName) {
        substatement = _SchemaName(schemaName, tableOrIndexName: _TableOrIndexName(indexName))
    }
}

@usableFromInline
protocol _AnalyzeSubstatement: Substatement {}

extension Analyze {
    @usableFromInline
    struct _SchemaName: _AnalyzeSubstatement {
        @usableFromInline
        let schemaName: SchemaName

        @usableFromInline
        let tableOrIndexName: _TableOrIndexName?

        @usableFromInline
        var substatementValue: String {
            "\(schemaName)\(tableOrIndexName.map { ".\($0.substatementValue)" } ?? "")"
        }

        @usableFromInline
        init(_ schemaName: SchemaName, tableOrIndexName: _TableOrIndexName? = nil) {
            self.schemaName = schemaName
            self.tableOrIndexName = tableOrIndexName
        }
    }

    @usableFromInline
    struct _TableOrIndexName: _AnalyzeSubstatement {
        @usableFromInline
        var substatementValue: String

        @usableFromInline
        init(_ value: Substatement) {
            substatementValue = "\(value)"
        }
    }
}
