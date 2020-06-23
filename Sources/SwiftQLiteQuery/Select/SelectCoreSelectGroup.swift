//
//  SelectCoreSelectGroup.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/26/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

@usableFromInline
struct SelectCoreSelectGroup: SelectCoreSelectGroupExtendableStatement {
    @usableFromInline
    var statementValue: String {
        let expressions = self.expressions.lazy
            .map(\.substatementValue)
            .joined(separator: ", ")
        let havingExpression = self.havingExpression.map { " HAVING \($0)" } ?? ""
        return "\(base) GROUP BY \(expressions)\(havingExpression)"
    }

    @usableFromInline
    let base: SelectCoreSelectWhereExtendableStatement
    
    @usableFromInline
    let expressions: [Expression]
    
    @usableFromInline
    let havingExpression: Expression?
    
    @usableFromInline
    init(_ base: SelectCoreSelectWhereExtendableStatement, expressions: [Expression], havingExpression: Expression?) {
        self.base = base
        self.expressions = expressions
        self.havingExpression = havingExpression
    }
}
