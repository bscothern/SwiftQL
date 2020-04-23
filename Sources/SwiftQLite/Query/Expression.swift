//
//  Expression.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 2/4/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

#warning("IMPLIMENT")
public struct Expression: Substatement {
    @inlinable
    public var substatementValue: String { "" }

    @inlinable
    public init(literal: Literal) {
    }
}
