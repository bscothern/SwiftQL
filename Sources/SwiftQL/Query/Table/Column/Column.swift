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
public struct Column: _Substatement {
    let name: String
    let type: DataType?
    let constraints: [ColumnConstraint]
    
    public var substatement: String { "" }
    
    public init(name: String, type: DataType?, constraints: [ColumnConstraint]) {
        self.name = name
        self.type = type
        self.constraints = constraints
    }
    
    public init(name: String, type: DataType, @PassThroughBuilder<ColumnConstraint> _ constraintsBuilder: () -> [ColumnConstraint]) {
        self.init(name: name, type: type, constraints: constraintsBuilder())
    }
}
