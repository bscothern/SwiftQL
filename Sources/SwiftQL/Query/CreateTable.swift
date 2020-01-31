//
//  CreateTable.swift
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

// TODO: Support schema-name
// TODO: Support AS select-stmt

/// Allows the creation of a table.
///
/// https://www.sqlite.org/lang_createtable.html
public struct CreateTable: Statement {
    public let name: String
    public let isTemporary: Bool
    public let ifNotExists: Bool
    public let withoutRowID: Bool
    public let columns: [Column]
    
    public var statement: String { "" }
    
    init(name: String, isTemporary: Bool, ifNotExists: Bool, withoutRowID: Bool = false, @PassThroughBuilder<Column> _ columnBuilder: () -> [Column]) {
        precondition(!name.hasPrefix("sqlite_"))
        self.name = name
        self.isTemporary = isTemporary
        self.ifNotExists = ifNotExists
        self.withoutRowID = withoutRowID
        self.columns = columnBuilder()
    }
}
