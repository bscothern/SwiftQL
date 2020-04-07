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
        let expressions = self.expressions
            .map { group -> String in
                let expressions = group.expressions
                    .map { "\($0)" }
                    .joined(separator: ", ")
                return "(\(expressions))"
            }
            .joined(separator: ", ")
        return "\(base) VALUES \(expressions)"
    }
    
    @usableFromInline
    let base: InsertSubstatement
    
    @usableFromInline
    let expressions: [ExpressionGroup]
    
    @usableFromInline
    init(_ base: InsertSubstatement, expressions: [ExpressionGroup]) {
        precondition(!expressions.isEmpty)
        self.base = base
        self.expressions = expressions
    }
}
