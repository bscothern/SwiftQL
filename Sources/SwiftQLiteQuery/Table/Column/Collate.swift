//
//  Collate.swift
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

extension ColumnConstraint {
    public enum CollateFunction: String {
        case binary = "BINARY"
        case noCase = "NOCASE"
        case rTrim = "RTRIM"
    }
}

@usableFromInline
struct Collate: ColumnConstraintSubstatement {
    @usableFromInline
    var substatementValue: String { "\(base) COLLATE \(function.rawValue)" }

    @usableFromInline
    let function: ColumnConstraint.CollateFunction

    @usableFromInline
    let base: ColumnConstraint

    @usableFromInline
    init(_ function: ColumnConstraint.CollateFunction, appendedTo base: ColumnConstraint) {
        self.function = function
        self.base = base
    }
}
