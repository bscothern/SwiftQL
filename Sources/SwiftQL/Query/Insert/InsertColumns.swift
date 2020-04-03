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
        ""
    }
    
    @usableFromInline
    let base: Insert
    
    @usableFromInline
    init(_ base: Insert) {
        self.base = base
    }
}
