//
//  SelectCoreSelect.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/24/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

@usableFromInline
struct SelectCoreSelect: SelectCoreSelectStatement {
    public enum Category: String {
        case all = "ALL"
        case distinct = "DISTINCT"
    }

    @usableFromInline
    var statementValue: String {
        let resultColumns = self.resultColumns.lazy
            .map(\.substatementValue)
            .joined(separator: ", ")
        return "SELECT \(category.rawValue) \(resultColumns)"
    }

    @usableFromInline
    let category: Category

    @usableFromInline
    let resultColumns: [ColumnName]
}
