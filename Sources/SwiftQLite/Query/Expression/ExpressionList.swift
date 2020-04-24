//
//  ExpressionList.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/22/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct ExpressionList: ExpressionSubstatement {
    @usableFromInline
    var substatementValue: String { "(\(list.map(\.substatementValue).joined(separator: ", ")))" }

    @usableFromInline
    let list: [ExpressionSubstatement]

    @usableFromInline
    init(_ list: [ExpressionSubstatement]) {
        precondition(!list.isEmpty)
        self.list = list
    }
}
