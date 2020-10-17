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

    @usableFromInline
    init<T>(schema: SchemaName? = nil, directive: String, equals value: T?) where T: LosslessStringConvertible {
        self.init(schema: schema, directive: directive, value: .equals(value))
    }

    @usableFromInline
    init<T>(schema: SchemaName? = nil, directive: String, parenthesis value: T?) where T: LosslessStringConvertible {
        self.init(schema: schema, directive: directive, value: .parenthesis(value))
    }
}

extension Pragma {
    @inlinable
    public static func analysisLimit(_ limit: Int32? = nil) -> Self {
        .init(directive: "analysis_limit", equals: limit)
    }

    @inlinable
    public static func applicationID(schema: SchemaName? = nil, id: Int32? = nil) -> Self {
        .init(
            schema: schema,
            directive: "application_id",
            equals: id
        )
    }

    @inlinable
    public static func autoVacuum(schema: SchemaName? = nil) -> Self {
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
    public static func autoVacuum(schema: SchemaName? = nil, mode: AutoVacuumMode) -> Self {
        .init(
            schema: schema,
            directive: "auto_vacuum",
            equals: mode.rawValue
        )
    }

    @inlinable
    public static func automaticIndex(_ value: Bool? = nil) -> Self {
        .init(
            directive: "automatic_index",
            equals: value
        )
    }

    @inlinable
    public static func busyTimeout(milliseconds: Int32? = nil) -> Self {
        .init(
            directive: "busy_timeout",
            equals: milliseconds
        )
    }

    @inlinable
    public static func cacheSize(schema: SchemaName? = nil, pages: Int32? = nil) -> Self {
        .init(
            schema: schema,
            directive: "cache_size",
            equals: pages
        )
    }
    
    @inlinable
    public static func cacheSize(schema: SchemaName? = nil, kibibytes: Int32) -> Self {
        .init(
            schema: schema,
            directive: "cache_size",
            equals: -kibibytes
        )
    }

    @inlinable
    public static func cacheSpill(enabled: Bool? = nil) -> Self {
        .init(
            directive: "cache_spill",
            equals: enabled
        )
    }

    @inlinable
    public static func cacheSpill(schema: SchemaName? = nil, threshold: Int32) -> Self {
        .init(
            schema: schema,
            directive: "cache_spill",
            equals: threshold
        )
    }

    @inlinable
    public static func caseSensitiveLike(enabled: Bool) -> Self {
        .init(
            directive: "case_sensitive_like",
            equals: enabled
        )
    }

    @inlinable
    public static func cellSizeCheck(enabled: Bool? = nil) -> Self {
        .init(
            directive: "cell_size_check",
            equals: enabled
        )
    }

    @inlinable
    public static func checkpointFullFsync(enabled: Bool? = nil) -> Self {
        .init(
            directive: "checkpoint_fullfsync",
            equals: enabled
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
            equals: enabled
        )
    }

    @inlinable
    @available(*, deprecated, message: "This pragma is deprecated and exists for backwards compatibility only. New applications should avoid using this pragma. Older applications should discontinue use of this pragma at the earliest opportunity. This pragma may be omitted from the build when SQLite is compiled using SQLITE_OMIT_DEPRECATED.")
    public static func dataStore(directory: String? = nil) -> Self {
        .init(
            directive: "data_store_directory",
            equals: directory.map { "'\($0)'" }
        )
    }

    @inlinable
    public static func dataVersion(schema: SchemaName? = nil) -> Self {
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
    public static func defaultCacheSize(schema: SchemaName? = nil, numberOfPages: Int32? = nil) -> Self {
        .init(
            schema: schema,
            directive: "default_cache_size",
            equals: numberOfPages
        )
    }

    @inlinable
    public static func deferForeignKeys(enabled: Bool? = nil) -> Self {
        .init(
            directive: "defer_foreign_keys",
            equals: enabled
        )
    }

    @inlinable
    @available(*, deprecated, message: "This pragma is deprecated and exists for backwards compatibility only. New applications should avoid using this pragma. Older applications should discontinue use of this pragma at the earliest opportunity. This pragma may be omitted from the build when SQLite is compiled using SQLITE_OMIT_DEPRECATED.")
    public static func emptyResultCallbacks(enabled: Bool? = nil) -> Self {
        .init(
            directive: "empty_result_callbacks",
            equals: enabled
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
            equals: value?.rawValue
        )
    }

    @inlinable
    public static func foreignKeyCheck(schema: SchemaName? = nil, table: TableName? = nil) -> Self {
        .init(
            schema: schema,
            directive: "foreign_key_check",
            parenthesis: table?.substatementValue
        )
    }

    @inlinable
    public static func foreignKeyList(table: TableName) -> Self {
        .init(
            directive: "foreign_key_list",
            parenthesis: table.substatementValue
        )
    }

    @inlinable
    public static func foreignKeys(enabled: Bool? = nil) -> Self {
        .init(
            directive: "foreign_keys",
            equals: enabled
        )
    }

    @inlinable
    public static func freelistCount(schema: SchemaName? = nil) -> Self {
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
            equals: enabled
        )
    }

    @inlinable
    public static func fullFSync(enabled: Bool? = nil) -> Self {
        .init(
            directive: "fullfsync",
            equals: enabled
        )
    }

    @inlinable
    public static func functionList() -> Self {
        .init(directive: "function_list")
    }

    @inlinable
    public static func hardHeapLimit(_ limit: Int64? = nil) -> Self {
        .init(
            directive: "hard_heap_limit",
            equals: limit
        )
    }

    @inlinable
    public static func ignoreCheckConstraints(_ enabled: Bool) -> Self {
        .init(
            directive: "ignore_check_constraints",
            equals: enabled
        )
    }

    @inlinable
    public static func incrementalVacuum(schema: SchemaName? = nil, numberOfPages: Int64) -> Self {
        .init(
            schema: schema,
            directive: "incremental_vacuum",
            parenthesis: numberOfPages
        )
    }

    @inlinable
    public static func indexInfo(schema: SchemaName? = nil, index: IndexName) -> Self {
        .init(
            schema: schema,
            directive: "index_info",
            parenthesis: index.substatementValue
        )
    }

    @inlinable
    public static func indexList(schema: SchemaName? = nil, table: TableName) -> Self {
        .init(
            schema: schema,
            directive: "index_list",
            parenthesis: table.substatementValue
        )
    }

    @inlinable
    public static func indexXInfo(schema: SchemaName? = nil, index: IndexName) -> Self {
        .init(
            schema: schema,
            directive: "index_xinfo",
            parenthesis: index.substatementValue
        )
    }

    @inlinable
    public static func integrityCheck(schema: SchemaName? = nil) -> Self {
        .init(
            schema: schema,
            directive: "integrity_check"
        )
    }

    @inlinable
    public static func integrityCheck(schema: SchemaName? = nil, maximumNumberOfErrors: Int64) -> Self {
        .init(
            schema: schema,
            directive: "integrity_check",
            parenthesis: maximumNumberOfErrors
        )
    }

    @inlinable
    public static func integrityCheck(schema: SchemaName? = nil, table: TableName) -> Self {
        .init(
            schema: schema,
            directive: "integrity_check",
            parenthesis: table.substatementValue
        )
    }

    public enum JournalMode: String {
        case delete = "DELETE"
        case truncate = "TRUNCATE"
        case persist = "PERSIST"
        case memory = "MEMORY"
        case wal = "WAL"
        case off = "OFF"
    }

    @inlinable
    public static func journalMode(schema: SchemaName? = nil, mode: JournalMode? = nil) -> Self {
        .init(
            schema: schema,
            directive: "journal_mode",
            equals: mode?.rawValue
        )
    }

    @inlinable
    public static func journalSizeLimit(_ limit: Int64? = nil) -> Self {
        .init(
            directive: "journal_size_limit",
            equals: limit
        )
    }

    @inlinable
    public static func legacyAlterTitle(_ enabled: Bool? = nil) -> Self {
        .init(
            directive: "legacy_alter_table",
            equals: enabled
        )
    }

    @inlinable
    public static func legacyFileFormat() -> Self {
        .init(directive: "legacy_file_format")
    }

    public enum LockingMode: String {
        case normal = "NORMAL"
        case exclusive = "EXCLUSIVE"
    }

    @inlinable
    public static func lockingMode(schema: SchemaName? = nil, mode: LockingMode? = nil) -> Self {
        .init(
            schema: schema,
            directive: "locking_mode",
            equals: mode?.rawValue
        )
    }

    @inlinable
    public static func maxPageCount(schema: SchemaName? = nil, count: Int64? = nil) -> Self {
        .init(
            schema: schema,
            directive: "max_page_count",
            equals: count
        )
    }

    @inlinable
    public static func mmapSize(schema: SchemaName? = nil, size: Int64? = nil) -> Self {
        .init(
            schema: schema,
            directive: "mmap_size",
            equals: size
        )
    }

    @inlinable
    public static func moduleList() -> Self {
        .init(directive: "module_list")
    }

    public struct OptimizeMask: OptionSet {
        public typealias RawValue = Int

        public static let debug = Self(rawValue: 1)
        public static let analyze = Self(rawValue: 2)

        @available(*, deprecated, message: "Not yet implemented by SQLite")
        public static let record = Self(rawValue: 4)

        @available(*, deprecated, message: "Not yet implemented by SQLite")
        public static let createHelpfulIndexes = Self(rawValue: 8)

        public let rawValue: RawValue

        @inlinable
        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }
    }

    @inlinable
    public static func optimize(schema: SchemaName? = nil, mask: OptimizeMask? = nil) -> Self {
        .init(
            schema: schema,
            directive: "optimize",
            parenthesis: mask?.rawValue
        )
    }

    @inlinable
    public static func pageCount(schema: SchemaName? = nil) -> Self {
        .init(
            schema: schema,
            directive: "page_count"
        )
    }

    @inlinable
    public static func pageSize(schema: SchemaName? = nil, bytes: Int) -> Self {
        .init(
            schema: schema,
            directive: "page_size",
            equals: bytes
        )
    }

    @inlinable
    @_spi(SQLiteDebugging)
    public static func parserTrace(enabled: Bool) -> Self {
        .init(
            directive: "parser_trace",
            equals: enabled
        )
    }

    @inlinable
    public static func pragmaList() -> Self {
        .init(directive: "pragma_list")
    }

    @inlinable
    public static func queryOnly(enabled: Bool? = nil) -> Self {
        .init(
            directive: "query_only",
            equals: enabled
        )
    }

    @inlinable
    public static func quickCheck(schema: SchemaName? = nil) -> Self {
        .init(
            schema: schema,
            directive: "quick_check"
        )
    }

    @inlinable
    public static func quickCheck(schema: SchemaName? = nil, maximumNumberOfErrors: Int64) -> Self {
        .init(
            schema: schema,
            directive: "quick_check",
            parenthesis: maximumNumberOfErrors
        )
    }

    @inlinable
    public static func quickCheck(schema: SchemaName? = nil, table: TableName) -> Self {
        .init(
            schema: schema,
            directive: "quick_check",
            parenthesis: table.substatementValue
        )
    }

    @inlinable
    public static func readUncommited(enabled: Bool? = nil) -> Self {
        .init(
            directive: "read_uncommited",
            equals: enabled
        )
    }
    
    @inlinable
    public static func recursiveTriggers(enabled: Bool? = nil) -> Self {
        .init(
            directive: "recursive_triggers",
            equals: enabled
        )
    }
    
    @inlinable
    public static func reverseUnorderedSelects(enabled: Bool? = nil) -> Self {
        .init(
            directive: "reverse_unordered_selects",
            equals: enabled
        )
    }
    
    @inlinable
    public static func schemaVersion(schema: SchemaName? = nil, number: Int32? = nil) -> Self {
        .init(
            schema: schema,
            directive: "schema_version",
            equals: number
        )
    }
    
    public enum SecureDeleteMode: String {
        case on
        case off
        case fast
        
        @inlinable
        public var rawValue: String {
            switch self {
            case .on:
                return "\(true)"
            case .off:
                return "\(false)"
            case .fast:
                return "FAST"
            }
        }
    }

    @inlinable
    public static func secureDelete(schema: SchemaName? = nil, mode: SecureDeleteMode? = nil) -> Self {
        .init(
            schema: schema,
            directive: "schema_version",
            equals: mode?.rawValue
        )
    }
    
    @inlinable
    @available(*, deprecated, message: "This pragma is deprecated and exists for backwards compatibility only. New applications should avoid using this pragma. Older applications should discontinue use of this pragma at the earliest opportunity. This pragma may be omitted from the build when SQLite is compiled using SQLITE_OMIT_DEPRECATED.")
    public static func shortColumnNames(enabled: Bool? = nil) -> Self {
        .init(
            directive: "short_column_names",
            equals: enabled
        )
    }
    
    @inlinable
    public static func shrinkMemory() -> Self {
        .init(directive: "shrink_memory")
    }
    
    @inlinable
    public static func softHeapLimit(size: Int64? = nil) -> Self {
        .init(
            directive: "soft_heap_limit",
            equals: size
        )
    }
    
    @inlinable
    public static func stats() -> Self {
        .init(directive: "stats")
    }
    
    public enum SynchronousMode: String {
        case off = "OFF"
        case normal = "NORMAL"
        case full = "FULL"
        case extra = "EXTRA"
    }
    
    @inlinable
    public static func synchronous(schema: SchemaName? = nil, mode: SynchronousMode? = nil) -> Self {
        .init(
            schema: schema,
            directive: "synchronous",
            equals: mode?.rawValue
        )
    }
    
    @inlinable
    public static func tableInfo(schema: SchemaName? = nil, table: TableName) -> Self {
        .init(
            schema: schema,
            directive: "table_info",
            parenthesis: table.substatementValue
        )
    }
    
    @inlinable
    public static func tableXInfo(schema: SchemaName? = nil, table: TableName) -> Self {
        .init(
            schema: schema,
            directive: "table_xinfo",
            parenthesis: table.substatementValue
        )
    }
    
    public enum TempStoreMode: String {
        case `default` = "DEFAULT"
        case file = "FILE"
        case memory = "MEMORY"
    }
    
    @inlinable
    public static func tempStore(mode: TempStoreMode? = nil) -> Self {
        .init(
            directive: "temp_store",
            equals: mode?.rawValue
        )
    }
    
    @inlinable
    @available(*, deprecated, message: "This pragma is deprecated and exists for backwards compatibility only. New applications should avoid using this pragma. Older applications should discontinue use of this pragma at the earliest opportunity. This pragma may be omitted from the build when SQLite is compiled using SQLITE_OMIT_DEPRECATED.")
    public static func tempStoreDirectory(_ directory: String? = nil) -> Self {
        .init(
            directive: "temp_store_directory",
            equals: directory
        )
    }
    
    @inlinable
    public static func threads(count: Int32) -> Self {
        .init(
            directive: "threads",
            equals: count
        )
    }
    
    @inlinable
    public static func trustedSchema(enabled: Bool? = nil) -> Self {
        .init(
            directive: "trusted_schema",
            equals: enabled
        )
    }
    
    @inlinable
    public static func userVersion(schema: SchemaName? = nil, number: Int32? = nil) -> Self {
        .init(
            schema: schema,
            directive: "user_version",
            equals: number
        )
    }
    
    @inlinable
    @_spi(SQLiteDebugging)
    public static func vdbeAddoptrace(enabled: Bool) -> Self {
        .init(
            directive: "vdbe_addoptrace",
            equals: enabled
        )
    }
    
    @inlinable
    @_spi(SQLiteDebugging)
    public static func vdbeDebug(enabled: Bool) -> Self {
        .init(
            directive: "vdbe_debug",
            equals: enabled
        )
    }
    
    @inlinable
    @_spi(SQLiteDebugging)
    public static func vdbeListinge(enabled: Bool) -> Self {
        .init(
            directive: "vdbe_listing",
            equals: enabled
        )
    }
    
    @inlinable
    @_spi(SQLiteDebugging)
    public static func vdbeTrace(enabled: Bool) -> Self {
        .init(
            directive: "vdbe_trace",
            equals: enabled
        )
    }
    
    @inlinable
    public static func walAutoCheckpoint(size: Int32) -> Self {
        .init(
            directive: "wal_autocheckpoint",
            equals: size
        )
    }
    
    public enum WALCheckpointMode: String {
        case passive = "PASSIVE"
        case full = "FULL"
        case restart = "RESTART"
        case truncate = "TRUNCATE"
    }
    
    @inlinable
    public static func walCheckpoint(schema: SchemaName? = nil, mode: WALCheckpointMode? = nil) -> Self {
        .init(
            schema: schema,
            directive: "wal_checkpoint",
            equals: mode?.rawValue
        )
    }
    
    @inlinable
    public static func writableSchema(enabled: Bool) -> Self {
        .init(
            directive: "writable_schema",
            equals: enabled
        )
    }
}
