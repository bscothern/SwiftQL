//
//  SchemaName.swift
//  SwiftQL
//
//  Created by Braden Scothern on 3/19/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct SchemaName {
    public let value: String
    
    @usableFromInline
    init(value: String) {
        self.value = value
    }
}

extension SchemaName: Substatement {
    @inlinable
    public var _substatement: String { value }
}

extension SchemaName: ExpressibleByStringLiteral {
    @inlinable
    public init(stringLiteral: String) {
        self.init(value: stringLiteral)
    }
}
