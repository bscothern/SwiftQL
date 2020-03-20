//
//  TableName.swift
//  SwiftQL
//
//  Created by Braden Scothern on 3/19/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct TableName {
    public let value: String
    
    @usableFromInline
    init(value: String) {
        self.value = value
    }
}

extension TableName: Substatement {
    @inlinable
    public var _substatement: String { value }
}

extension TableName: ExpressibleByStringLiteral {
    @inlinable
    public init(stringLiteral: String) {
        self.init(value: stringLiteral)
    }
}
