//
//  SelectCoreValues.swift
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
struct SelectCoreValues: SelectCoreStatement {
    @usableFromInline
    var statementValue: String {
        let expressionLists = self.expressionLists.lazy
            .map { expressions -> String in
                let expressionList = expressions.lazy
                    .map(\.substatementValue)
                    .joined(separator: ", ")
                return "(\(expressionList))"
            }
            .joined(separator: ", ")
        return "VALUES \(expressionLists)"
    }

    @usableFromInline
    let expressionLists: [[ExpressionSubstatement]]

    @usableFromInline
    init(expressionLists: [[ExpressionSubstatement]]) {
        assert(!expressionLists.isEmpty)
        assert(expressionLists.allSatisfy { !$0.isEmpty })
        self.expressionLists = expressionLists
    }
}
