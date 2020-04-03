//
//  InsertUpsert.swift
//  SwiftQL
//
//  Created by Braden Scothern on 4/2/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct InsertUpsert: InsertStatement {
    @usableFromInline
    var _statement: String { "\(base) \(upsert)" }
    
    @usableFromInline
    let base: InsertStatement
    
    @usableFromInline
    let upsert: Upsert
    
    @usableFromInline
    init(_ base: InsertStatement, upsert: Upsert) {
        self.base = base
        self.upsert = upsert
    }
}
