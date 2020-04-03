//
//  IndexName.swift
//  SwiftQL
//
//  Created by Braden Scothern on 3/19/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct IndexName: Name {
    @inlinable
    public var _substatement: String { value }

    public let value: String

    @inlinable
    public init(_ value: String) {
        self.value = value
    }
}

extension IndexName: ExpressibleByStringLiteral {
    @inlinable
    public init(stringLiteral: String) {
        self.init(stringLiteral)
    }
}
