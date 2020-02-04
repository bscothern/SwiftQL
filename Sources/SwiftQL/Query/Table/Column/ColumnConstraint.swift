//
//  ColumnConstraint.swift
//  SwiftQL
//
//  Created by Braden Scothern on 2/3/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLLinux
#else
import SQLite3
#endif

#warning("Support Check")
#warning("Support Default")
#warning("Support Collate")
#warning("Support foreign-key-clause")
#warning("Support (Generated Always) As")

/// https://www.sqlite.org/syntax/column-constraint.html
public protocol ColumnConstraint: _Substatement {}
