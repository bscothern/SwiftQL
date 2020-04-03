//
//  ViewName.swift
//  SwiftQL
//
//  Created by Braden Scothern on 3/19/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct ViewName: Name {
    public let value: String

    @inlinable
    public var _substatement: String { value }

    @inlinable
    public init(_ value: String) {
        self.value = value
    }
}

extension ViewName: ExpressibleByStringLiteral {
    @inlinable
    public init(stringLiteral: String) {
        self.init(stringLiteral)
    }
}
