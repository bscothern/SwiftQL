//
//  String.StringInterpolation.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 3/17/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

extension String.StringInterpolation {
    @inlinable
    public mutating func appendIntepolation(_ statement: Statement, leadingSpace: Bool = false, trailingSpace: Bool = false) {
        appendInterpolation("\(leadingSpace ? " " : "")\(statement.statementValue)\(trailingSpace ? " " : "")")
    }

    @inlinable
    public mutating func appendInterpolation(_ substatement: Substatement, leadingSpace: Bool = false, trailingSpace: Bool = false) {
        appendInterpolation("\(leadingSpace ? " " : "")\(substatement.substatementValue)\(trailingSpace ? " " : "")")
    }

    @inlinable
    public mutating func appendIntepolation(_ statement: Statement?, leadingSpace: Bool = false, trailingSpace: Bool = false) {
        appendInterpolation(statement.map { "\(leadingSpace ? " " : "")\($0.statementValue)\(trailingSpace ? " " : "")" } ?? "")
    }

    @inlinable
    public mutating func appendInterpolation(_ substatement: Substatement?, leadingSpace: Bool = false, trailingSpace: Bool = false) {
        appendInterpolation(substatement.map { "\(leadingSpace ? " " : "")\($0.substatementValue)\(trailingSpace ? " " : "")" } ?? "")
    }
}
