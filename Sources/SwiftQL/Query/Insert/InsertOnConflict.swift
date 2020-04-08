//
//  InsertOnConflict.swift
//  SwiftQL
//
//  Created by Braden Scothern on 4/7/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct InsertOnConflict: InsertOnConflictWhereSubstatement {
    @usableFromInline
    var _substatement: String {
        let columns = indexedColumns.isEmpty ? "" : " (\(indexedColumns.map(\.value).joined(separator: ", "))"
        return "\(base)\(columns)"
    }

    @usableFromInline
    let base: InsertStatement

    @usableFromInline
    let indexedColumns: [IndexedColumnName]

    @usableFromInline
    init(_ base: InsertStatement, indexedColumns: [IndexedColumnName]) {
        self.base = base
        self.indexedColumns = indexedColumns
    }
}
