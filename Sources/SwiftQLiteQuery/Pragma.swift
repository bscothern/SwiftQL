//
//  Pragma.swift
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

#warning("IMPLIMENT")
public struct Pragma: Statement {
    @inlinable
    public var statementValue: String {
        let schema = self.schema.map { "\($0)." } ?? ""
        let value = self.value?.substatementValue ?? ""
        return "PRAGMA \(schema)\(directive)\(value)"
    }

    @usableFromInline
    let schema: SchemaName?

    @usableFromInline
    let directive: String

    @usableFromInline
    let value: Value?

    @usableFromInline
    struct Value: Substatement {
        @usableFromInline
        var substatementValue: String

        @usableFromInline
        init(_ value: String) {
            self.substatementValue = value
        }

        @usableFromInline
        static func equals<T>(_ value: T?) -> Self? where T: LosslessStringConvertible {
            value
                .map { "= \($0)" }
                .map(Self.init)
        }

        @usableFromInline
        static func parenthesis<T>(_ value: T?) -> Self? where T: LosslessStringConvertible {
            value
                .map { "(\($0))" }
                .map(Self.init)
        }
    }

    @usableFromInline
    init(schema: SchemaName? = nil, directive: String) {
        self.schema = schema
        self.directive = directive
        self.value = nil
    }

    @usableFromInline
    init(schema: SchemaName? = nil, directive: String, value: Value?) {
        self.schema = schema
        self.directive = directive
        self.value = value
    }
}

extension Pragma {
    @inlinable
    public static func analysisLimit(_ limit: Int32? = nil) -> Self {
        .init(directive: "analysis_limit", value: .equals(limit))
    }

    @inlinable
    public static func applicationID(schema: SchemaName, id: Int32? = nil) -> Self {
        .init(
            schema: schema,
            directive: "application_id",
            value: .equals(id)
        )
    }

    @inlinable
    public static func autoVacuum(schema: SchemaName) -> Self {
        .init(
            schema: schema,
            directive: "auto_vacuum"
        )
    }

    public enum AutoVacuumMode: String {
        case none = "NONE"
        case full = "FULL"
        case incremental = "INCREMENTAL"
    }

    @inlinable
    public static func autoVacuum(schema: SchemaName, mode: AutoVacuumMode) -> Self {
        .init(
            schema: schema,
            directive: "auto_vacuum",
            value: .equals(mode.rawValue)
        )
    }

    @inlinable
    public static func automaticIndex(_ value: Bool? = nil) -> Self {
        .init(
            directive: "automatic_index",
            value: .equals(value)
        )
    }

    @inlinable
    public static func busyTimeout(milliseconds: Int32? = nil) -> Self {
        .init(
            directive: "busy_timeout",
            value: .equals(milliseconds)
        )
    }

    @inlinable
    public static func cacheSize() -> Self {
        #warning("TODO")
        fatalError("TODO")
    }

    @inlinable
    public static func cacheSpill(enabled: Bool? = nil) -> Self {
        .init(
            directive: "cache_spill",
            value: .equals(enabled)
        )
    }

    @inlinable
    public static func cacheSpill(schema: SchemaName, threshold: Int32) -> Self {
        .init(
            schema: schema,
            directive: "cache_spill",
            value: .equals(threshold)
        )
    }

    @inlinable
    public static func caseSensitiveLike(enabled: Bool) -> Self {
        .init(
            directive: "case_sensitive_like",
            value: .equals(enabled)
        )
    }

    @inlinable
    public static func cellSizeCheck(enabled: Bool? = nil) -> Self {
        .init(
            directive: "cell_size_check",
            value: .equals(enabled)
        )
    }

    @inlinable
    public static func checkpointFullFsync(enabled: Bool? = nil) -> Self {
        .init(
            directive: "checkpoint_fullfsync",
            value: .equals(enabled)
        )
    }

    @inlinable
    public static func collationList() -> Self {
        .init(directive: "collation_list")
    }

    @inlinable
    public static func compileOptions() -> Self {
        .init(directive: "compile_options")
    }

    @inlinable
    @available(*, deprecated, message: "This pragma is deprecated and exists for backwards compatibility only. New applications should avoid using this pragma. Older applications should discontinue use of this pragma at the earliest opportunity. This pragma may be omitted from the build when SQLite is compiled using SQLITE_OMIT_DEPRECATED.")
    public static func countChanges(enabled: Bool? = nil) -> Self {
        .init(
            directive: "count_changes",
            value: .equals(enabled)
        )
    }

    @inlinable
    @available(*, deprecated, message: "This pragma is deprecated and exists for backwards compatibility only. New applications should avoid using this pragma. Older applications should discontinue use of this pragma at the earliest opportunity. This pragma may be omitted from the build when SQLite is compiled using SQLITE_OMIT_DEPRECATED.")
    public static func dataStore(directory: String? = nil) -> Self {
        .init(
            directive: "data_store_directory",
            value: .equals(directory.map { "'\($0)'" })
        )
    }

    @inlinable
    public static func dataVersion(schema: SchemaName) -> Self {
        .init(
            schema: schema,
            directive: "data_version"
        )
    }

    @inlinable
    public static func databaseList() -> Self {
        .init(directive: "database_list")
    }

    @inlinable
    @available(*, deprecated, message: "This pragma is deprecated and exists for backwards compatibility only. New applications should avoid using this pragma. Older applications should discontinue use of this pragma at the earliest opportunity. This pragma may be omitted from the build when SQLite is compiled using SQLITE_OMIT_DEPRECATED.")
    public static func defaultCacheSize(schema: SchemaName, numberOfPages: Int32? = nil) -> Self {
        .init(
            schema: schema,
            directive: "default_cache_size",
            value: .equals(numberOfPages)
        )
    }

    @inlinable
    public static func deferForeignKeys(enabled: Bool? = nil) -> Self {
        .init(
            directive: "defer_foreign_keys",
            value: .equals(enabled)
        )
    }

    @inlinable
    @available(*, deprecated, message: "This pragma is deprecated and exists for backwards compatibility only. New applications should avoid using this pragma. Older applications should discontinue use of this pragma at the earliest opportunity. This pragma may be omitted from the build when SQLite is compiled using SQLITE_OMIT_DEPRECATED.")
    public static func emptyResultCallbacks(enabled: Bool? = nil) -> Self {
        .init(
            directive: "empty_result_callbacks",
            value: .equals(enabled)
        )
    }

    public enum Encoding: String {
        case utf8 = "'UTF-8'"
        case utf16 = "'UTF-16'"
        case utf16le = "'UTF-16le'"
        case utf16be = "'UTF-16be'"
    }

    @inlinable
    public static func encoding(_ value: Encoding? = nil) -> Self {
        .init(
            directive: "encoding",
            value: .equals(value?.rawValue)
        )
    }

    @inlinable
    public static func foreignKeyCheck(schema: SchemaName, table: TableName? = nil) -> Self {
        .init(
            schema: schema,
            directive: "foreign_key_check",
            value: .parenthesis(table?.substatementValue)
        )
    }

    @inlinable
    public static func foreignKeyList(table: TableName) -> Self {
        .init(
            directive: "foreign_key_list",
            value: .parenthesis(table.substatementValue)
        )
    }

    @inlinable
    public static func foreignKeys(enabled: Bool? = nil) -> Self {
        .init(
            directive: "foreign_keys",
            value: .equals(enabled)
        )
    }

    @inlinable
    public static func freelistCount(schema: SchemaName) -> Self {
        .init(
            schema: schema,
            directive: "freelist_count"
        )
    }

    @inlinable
    @available(*, deprecated, message: "This pragma is deprecated and exists for backwards compatibility only. New applications should avoid using this pragma. Older applications should discontinue use of this pragma at the earliest opportunity. This pragma may be omitted from the build when SQLite is compiled using SQLITE_OMIT_DEPRECATED.")
    public static func fullColumnNames(enabled: Bool? = nil) -> Self {
        .init(
            directive: "full_column_names",
            value: .equals(enabled)
        )
    }

    @inlinable
    public static func fullFSync(enabled: Bool? = nil) -> Self {
        .init(
            directive: "fullfsync",
            value: .equals(enabled)
        )
    }

    @inlinable
    public static func functionList() -> Self {
        .init(directive: "function_list")
    }

    @inlinable
    public static func hardHeapLimit(_ value: Int64? = nil) -> Self {
        .init(
            directive: "hard_heap_limit",
            value: .equals(value)
        )
    }

    @inlinable
    public static func ignoreCheckConstraints(_ value: Bool) -> Self {
        .init(
            directive: "ignore_check_constraints",
            value: .equals(value)
        )
    }

    @inlinable
    public static func incrementalVacuum(schema: SchemaName, numberOfPages: Int64) -> Self {
        .init(
            schema: schema,
            directive: "incremental_vacuum",
            value: .parenthesis(numberOfPages)
        )
    }

    @inlinable
    public static func indexInfo(schema: SchemaName, index: IndexName) -> Self {
        .init(
            schema: schema,
            directive: "index_info",
            value: .parenthesis(index.substatementValue)
        )
    }

    @inlinable
    public static func indexList(schema: SchemaName, table: TableName) -> Self {
        .init(
            schema: schema,
            directive: "index_list",
            value: .parenthesis(table.substatementValue)
        )
    }

    @inlinable
    public static func indexXInfo(schema: SchemaName, index: IndexName) -> Self {
        .init(
            schema: schema,
            directive: "index_xinfo",
            value: .parenthesis(index.substatementValue)
        )
    }

    @inlinable
    public static func integrityCheck(schema: SchemaName) -> Self {
        .init(
            schema: schema,
            directive: "integrity_check"
        )
    }

    @inlinable
    public static func integrityCheck(schema: SchemaName, maximumNumberOfErrors: Int64) -> Self {
        .init(
            schema: schema,
            directive: "integrity_check",
            value: .parenthesis(maximumNumberOfErrors)
        )
    }

    @inlinable
    public static func integrityCheck(schema: SchemaName, table: TableName) -> Self {
        .init(
            schema: schema,
            directive: "integrity_check",
            value: .parenthesis(table.substatementValue)
        )
    }
}
