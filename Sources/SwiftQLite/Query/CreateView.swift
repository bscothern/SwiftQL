//
//  CreateView.swift
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

/// https://www.sqlite.org/lang_createview.html
public struct CreateView: Statement {
    public var _statement: String {
        let isTemporary = self.isTemporary ? " TEMPORARY" : ""
        let ifNotExists = self.ifNotExists ? " IF NOT EXISTS" : ""
        let schemaName = self.schemaName.map { "\($0)." } ?? ""
        let name = self.name
        let columnNames = !self.columnNames.isEmpty ? " (\(self.columnNames.joined(separator: ", ")))" : ""
        let select = self.select
        return "CREATE\(isTemporary) VIEW\(ifNotExists) \(schemaName)\(name)\(columnNames) AS \(select)"
    }

    @usableFromInline
    let name: String

    @usableFromInline
    let schemaName: SchemaName?

    @usableFromInline
    let isTemporary: Bool

    @usableFromInline
    let ifNotExists: Bool

    @usableFromInline
    let columnNames: [String]

    @usableFromInline
    let select: Select

    @inlinable
    public init(name: String, schemaName: SchemaName? = nil, isTemporary: Bool = false, ifNotExists: Bool = true, columnNames: [String], as select: Select) {
        self.name = name
        self.schemaName = schemaName
        self.isTemporary = isTemporary
        self.ifNotExists = ifNotExists
        self.columnNames = columnNames
        self.select = select
    }
}
