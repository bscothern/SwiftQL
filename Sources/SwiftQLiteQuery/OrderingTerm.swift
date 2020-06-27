//
//  OrderingTerm.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 6/23/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct OrderingTerm: Substatement {
    public enum Ordering: String {
        case ascending = "ASC"
        case descending = "DESC"
    }

    public enum Nulls: String {
        case first = "NULLS FIRST"
        case last = "NULLS LAST"
    }

    @inlinable
    public var substatementValue: String {
        let collationName = self.collationName.map { " COLLATE \($0)" } ?? ""
        let ordering = self.ordering.map { " \($0.rawValue)" } ?? ""
        let nulls = self.nulls.map { " \($0.rawValue)" } ?? ""
        return "\(expression)\(collationName)\(ordering)\(nulls)"
    }

    @usableFromInline
    let expression: Expression

    @usableFromInline
    let collationName: CollationName?

    @usableFromInline
    let ordering: Ordering?

    @usableFromInline
    let nulls: Nulls?

    public init(expression: Expression, collate collationName: CollationName? = nil, ordering: Ordering? = nil, nulls: Nulls? = nil) {
        self.expression = expression
        self.collationName = collationName
        self.ordering = ordering
        self.nulls = nulls
    }
}
