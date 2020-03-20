//
//  DropStatementBase.swift
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

/// This type is used by `DropIndex`, `DropTable`, `DropTrigger`, and `DropView` to share their common components.
@usableFromInline
struct DropStatementBase: Statement {
    @usableFromInline
    enum Category: String {
        case index = "INDEX"
        case table = "TABLE"
        case trigger = "TRIGGER"
        case view = "VIEW"
    }

    @usableFromInline
    var _statement: String {
        let ifExists = self.ifExists ? "IF EXISTS " : ""
        let schemaName = self.schemaName.map { "\($0)." } ?? ""
        return "DROP \(category.rawValue) \(ifExists)\(schemaName)\(name)"
    }

    @usableFromInline
    let category: Category

    @usableFromInline
    let name: String

    @usableFromInline
    let ifExists: Bool

    @usableFromInline
    let schemaName: SchemaName?

    @usableFromInline
    init(_ category: Category, name: String, schemaName: SchemaName?, ifExists: Bool) {
        self.category = category
        self.name = name
        self.ifExists = ifExists
        self.schemaName = schemaName
    }
}
