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
    @usableFromInline let name: String
    @usableFromInline let type: DataType?
    @usableFromInline let constraints: [ColumnConstraint]

    @inlinable public var substatement: String { "" }

    @inlinable
    public init(name: String, type: DataType?, constraints: [ColumnConstraint]) {
        self.name = name
        self.type = type
        self.constraints = constraints
    }

    @inlinable
    public init(name: String, type: DataType, @PassThroughBuilder<ColumnConstraint> _ constraintsBuilder: () -> [ColumnConstraint]) {
        //swiftlint:disable:previous attributes
        self.init(name: name, type: type, constraints: constraintsBuilder())
    }
}
