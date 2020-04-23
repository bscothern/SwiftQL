//
//  Update.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 1/30/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

public protocol UpdateStatement: Statement {}

public struct Update: UpdateStatement {
    public var _statement: String {
        let with = self.with.map { "\($0) " } ?? ""
        let or = self.or.map { "OR \($0) " } ?? ""
        let tableName = self.tableName
        let set = self.set.lazy
            .map { "\($0.0) = \($0.1)" }
            .joined(separator: ", ")
        return "\(with)UPDATE \(or)\(tableName) SET \(set)"
    }

    @usableFromInline
    let tableName: TableName

    @usableFromInline
    let with: With?

    @usableFromInline
    let or: Or?

    @usableFromInline
    let set: [(name: String, to: Literal)]

    @inlinable
    public init(tableName: TableName, with: With?, or: Or?, @PassThroughBuilder<(name: String, to: Literal)> set: () -> [(name: String, to: Literal)]) {
        self.tableName = tableName
        self.with = with
        self.or = or
        self.set = set()
    }

    public func `where`(_ expression: Expression) -> some UpdateStatement {
        UpdateWhere(base: self, expression: expression)
    }
}

@usableFromInline
struct UpdateWhere: UpdateStatement {
    @usableFromInline
    var _statement: String {
        "\(base) WHERE \(expression)"
    }

    @usableFromInline
    let base: Update

    @usableFromInline
    let expression: Expression

    @usableFromInline
    init(base: Update, expression: Expression) {
        self.base = base
        self.expression = expression
    }
}
