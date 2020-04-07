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
        "\(base)"
    }
    
    @usableFromInline
    let base: ColumnEditableInsert
    
    @usableFromInline
    init(_ base: ColumnEditableInsert) {
        self.base = base
    }
}
