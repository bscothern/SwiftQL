//
//  SelectOrderBy.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 6/23/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct SelectOrderBy: SelectLimitExtendableStatement {
    @usableFromInline
    var statementValue: String {
        let orderingTerms = self.orderingTerms.lazy
            .map(\.substatementValue)
            .joined(separator: ", ")
        return "\(base) ORDER BY \(orderingTerms)"
    }

    @usableFromInline
    let base: SelectStatement

    @usableFromInline
    let orderingTerms: [OrderingTerm]

    @usableFromInline
    init(_ base: SelectStatement, orderingTerms: [OrderingTerm]) {
        self.base = base
        self.orderingTerms = orderingTerms
    }
}
