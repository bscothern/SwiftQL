//
//  InsertColumns.swift
//  SwiftQL
//
//  Created by Braden Scothern on 4/2/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct InsertColumns: InsertSubstatement {
    @usableFromInline
    var _substatement: String {
        let columnNames = names.isEmpty ? "" : " (\(names.map(\.value).joined(separator: ", ")))"
        return "\(base)\(columnNames)"
    }

    @usableFromInline
    let base: ColumnEditableInsert
    
    @usableFromInline
    let names: [ColumnName]
    
    @usableFromInline
    init(_ base: ColumnEditableInsert, names: [ColumnName]) {
        self.base = base
        self.names = names
    }
}
