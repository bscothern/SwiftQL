//
//  String.StringInterpolation.swift
//  SwiftQL
//
//  Created by Braden Scothern on 3/17/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

extension String.StringInterpolation {
    @inlinable
    public mutating func appendIntepolation(_ statement: Statement) {
        appendInterpolation(statement._statement)
    }

    @inlinable
    public mutating func appendInterpolation(_ substatement: Substatement) {
        appendInterpolation(substatement._substatement)
    }
}
