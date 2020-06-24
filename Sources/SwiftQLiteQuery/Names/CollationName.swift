//
//  CollationName.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 6/23/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct CollationName: Name {
    @inlinable
    public var substatementValue: String { value }

    public let value: String

    @inlinable
    public init(_ value: String) {
        self.value = value
    }
}

extension CollationName: ExpressibleByStringLiteral {
    @inlinable
    public init(stringLiteral: String) {
        self.init(stringLiteral)
    }
}
