//
//  Statement.swift
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

public protocol Statement {
    var statement: String { get }
}

public protocol _Substatement {
    var substatement: String { get }
}
