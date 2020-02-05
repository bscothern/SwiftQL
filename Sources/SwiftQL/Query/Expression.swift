//
//  Expression.swift
//  SwiftQL
//
//  Created by Braden Scothern on 2/4/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLLinux
#else
import SQLite3
#endif

#warning("IMPLIMENT")
public struct Expression: Substatement {
    @inlinable public var substatement: String { "" }
}
