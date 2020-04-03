//
//  InsertValues.swift
//  SwiftQL
//
//  Created by Braden Scothern on 4/2/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct InsertValues: InsertStatement, UpsertableInsert {
    @usableFromInline
    var _statement: String {
        let values = ""
        return "\(base) VALUES \(values)"
    }
    
    @usableFromInline
    let base: InsertSubstatement
    
    @usableFromInline
    init(_ base: InsertSubstatement) {
        self.base = base
    }
}
