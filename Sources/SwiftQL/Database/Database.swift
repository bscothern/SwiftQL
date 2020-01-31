//
//  Database.swift
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

import Foundation

public final class Database {
    // MARK: - Stored Properties
    // MARK: Public
    /// The file used to open the database.
    public private(set) var fileName: String
    /// `true` if the database is currently open, otherwise `false`.
    public private(set) var isOpen: Bool = false

    // MARK: Internal
    @usableFromInline var handle: OpaquePointer?
    
    // MARK: - Init
    /// Creates a `Database` using the provided filename.
    ///
    /// - Parameter fileName: The filename to the database such that its CString can be used to open the database.
    init(fileName: String) {
        self.fileName = fileName
    }
    
    // MARK: - Deinit
    deinit {
        sqlite3_close_v2(handle)
    }
}

// MARK: - Common Types
// MARK: Public
public extension Database {
    enum Error: Swift.Error {
        case alreadyOpen
        case alreadyClosed
    }
    
    struct SQLiteError: Swift.Error {
        public let code: CInt
        public let description: String
        
        init(code: CInt, handle: OpaquePointer?) {
            self.code = code
            description = .init(cString: sqlite3_errmsg(handle))
        }
    }
}

// MARK: - Open
public extension Database {
    // TODO: Support VFS instead of always setting it to nil
    @discardableResult
    func open(mode: OpenMode, flags: OpenFlag) throws -> Self {
        guard !isOpen else {
            throw Error.alreadyOpen
        }
        let openResult = fileName.withUTF8 { cString in
            cString.withMemoryRebound(to: Int8.self) { cString in
                sqlite3_open_v2(cString.baseAddress, &handle, mode.rawValue | flags.rawValue, nil)
            }
        }
        defer {
            // It is possible to open even if openResult is no ok
            isOpen = handle != nil
        }
        guard openResult == SQLITE_OK else {
            throw SQLiteError(code: openResult, handle: handle)
        }
        return self
    }
    
    /// One of the valid modes that a database can be opened in.
    enum OpenMode: CInt, CaseIterable {
        public var rawValue: CInt {
            switch self {
            case .readOnly:
                return SQLITE_OPEN_READONLY
            case .readWrite:
                return SQLITE_OPEN_READWRITE
            case .readWriteCreate:
                return SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE
            }
        }
        
        /// The database is opened in read-only mode.
        /// If the database does not already exist, an error is returned.
        case readOnly

        /// The database is opened for reading and writing if possible, or reading only if the file is write protected by the operating system.
        /// In either case the database must already exist, otherwise an error is returned.
        case readWrite

        /// The database is opened for reading and writing, and is created if it does not already exist.
        case readWriteCreate
    }

    /// Flags that can be set when opening a database connection.
    struct OpenFlag: OptionSet {
        public let rawValue: CInt

        /// The filename can be interpreted as a URI if this flag is set.
        public static let uri = Self(rawValue: SQLITE_OPEN_URI)
        
        /// The database will be opened as an in-memory database.
        /// The database is named by the "filename" argument for the purposes of cache-sharing, if shared cache mode is enabled, but the "filename" is otherwise ignored.
        public static let memory = Self(rawValue: SQLITE_OPEN_MEMORY)
        
        /// The new database connection will use the "multi-thread" threading mode.
        /// This means that separate threads are allowed to use SQLite at the same time, as long as each thread is using a different database connection.
        public static let noMutex = Self(rawValue: SQLITE_OPEN_NOMUTEX)
        
        /// The new database connection will use the "serialized" threading mode.
        /// This means the multiple threads can safely attempt to use the same database connection at the same time.
        /// (Mutexes will block any actual concurrency, but in this mode there is no harm in trying.)
        public static let fullMutex = Self(rawValue: SQLITE_OPEN_FULLMUTEX)
        
        /// The database is opened shared cache enabled, overriding the default shared cache setting provided by sqlite3_enable_shared_cache().
        public static let sharedCache = Self(rawValue: SQLITE_OPEN_SHAREDCACHE)
        
        /// The database is opened shared cache disabled, overriding the default shared cache setting provided by sqlite3_enable_shared_cache().
        public static let privateCache = Self(rawValue: SQLITE_OPEN_PRIVATECACHE)

        // This value isn't supported on apple devices at this time.
        /// The database filename is not allowed to be a symbolic link
        //public static let noFollow = Self(rawValue: SQLITE_OPEN_NOFOLLOW)

        public init(rawValue: CInt) {
            self.rawValue = rawValue
        }
    }
}

// MARK:- Close
public extension Database {
    /// Attempt to close the `Database`.
    ///
    /// This throws if there are unfinalized prepared statements or unfinished backup objects.
    func close() throws {
        let closeResult = sqlite3_close(handle)
        guard closeResult == SQLITE_OK else {
            throw SQLiteError(code: closeResult, handle: handle)
        }
        handle = nil
        isOpen = false
    }

    /// Force the `Database` to close now so no further operations can take place.
    ///
    /// - Warning: If this is used you will not be able to know when all resources are deallocated.
    ///
    /// This will put the database into a zombie state.
    /// Resources for the database will not be cleaned up until all prepared statements are finalized, BLOBs are closed, and all backups are finished.
    func closeNow() throws {
        let closeResult = sqlite3_close_v2(handle)
        handle = nil
        isOpen = false
        guard closeResult == SQLITE_OK else {
            throw SQLiteError(code: closeResult, handle: handle)
        }
    }
}
