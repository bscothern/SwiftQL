//
//  Column.swift
//  SwiftQL
//
//  Created by Braden Scothern on 1/30/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLLinux
#else
import SQLite3
#endif

/// https://www.sqlite.org/syntax/column-def.html
public struct Column: Substatement {
    @usableFromInline
    let name: ColumnName

    @usableFromInline
    let type: DataType?

    @usableFromInline
    let constraints: [ColumnConstraintSubstatement]

    @inlinable
    public var _substatement: String {
        let type = self.type.map { " \($0.rawValue)" } ?? ""
        let constraints = self.constraints.lazy
            .map { " \($0)" }
            .joined(separator: ",")
        return "\(name)\(type)\(constraints)"
    }

    @usableFromInline
    init(name: ColumnName, type: DataType?, constraints: [ColumnConstraintSubstatement]) {
        self.name = name
        self.type = type
        self.constraints = constraints
    }

    @inlinable
    public init(name: ColumnName, type: DataType, @PassThroughBuilder<ColumnConstraintSubstatement> constraints constraintsBuilder: () -> [ColumnConstraintSubstatement]) {
        self.init(name: name, type: type, constraints: constraintsBuilder())
    }
}
