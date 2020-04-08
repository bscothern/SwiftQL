//
//  InsertOnConflictWhere.swift
//  SwiftQL
//
//  Created by Braden Scothern on 4/7/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct InsertOnConflictWhere: InsertOnConflictSubstatement {
    @usableFromInline
    var _substatement: String { "\(base) WHERE \(expression)" }
    
    @usableFromInline
    let base: InsertOnConflictWhereSubstatement
    
    @usableFromInline
    let expression: Expression
    
    @usableFromInline
    init(_ base: InsertOnConflictWhereSubstatement, expression: Expression) {
        self.base = base
        self.expression = expression
    }
}
