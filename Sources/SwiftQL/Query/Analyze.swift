//
//  Analyze.swift
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

public struct Analyze: Statement {
    @inlinable
    public var _statement: String {
        "ANALYZE \(substatement._substatement)"
    }

    @usableFromInline
    let substatement: _AnalyzeSubstatement

    @inlinable
    public init(schemaName: String) {
        substatement = _SchemaName(schemaName)
    }

    @inlinable
    public init(tableName: String) {
        substatement = _TableOrIndexName(tableName)
    }

    @inlinable
    public init(indexName: String) {
        substatement = _TableOrIndexName(indexName)
    }

    @inlinable
    public init(schemaName: String, tableName: String) {
        substatement = _SchemaName(schemaName, tableOrIndexName: _TableOrIndexName(tableName))
    }

    @inlinable
    public init(schemaName: String, indexName: String) {
        substatement = _SchemaName(schemaName, tableOrIndexName: _TableOrIndexName(indexName))
    }
}

@usableFromInline
protocol _AnalyzeSubstatement: Substatement {}

extension Analyze {
    @usableFromInline
    struct _SchemaName: _AnalyzeSubstatement {
        @usableFromInline
        let schemaName: String

        @usableFromInline
        let tableOrIndexName: _TableOrIndexName?

        @usableFromInline
        var _substatement: String { "\(schemaName)\(tableOrIndexName.map { ".\($0._substatement)" } ?? "")" }

        @usableFromInline
        init(_ schemaName: String, tableOrIndexName: _TableOrIndexName? = nil) {
            self.schemaName = schemaName
            self.tableOrIndexName = tableOrIndexName
        }
    }

    @usableFromInline
    struct _TableOrIndexName: _AnalyzeSubstatement {
        @usableFromInline
        var _substatement: String

        @usableFromInline
        init(_ value: String) {
            _substatement = value
        }
    }
}
