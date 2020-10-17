//
//  Statement.swift
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

public protocol Statement {
    var statementValue: String { get }
}

public protocol Substatement {
    var substatementValue: String { get }
}

extension Substatement where Self: RawRepresentable, RawValue == String {
    @inlinable
    public var substatementValue: String { rawValue }
}
