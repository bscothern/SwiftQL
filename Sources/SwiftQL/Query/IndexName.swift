//
//  IndexName.swift
//  SwiftQL
//
//  Created by Braden Scothern on 3/19/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct IndexName {
    public let value: String
    
    @usableFromInline
    init(value: String) {
        self.value = value
    }
}

extension IndexName: Substatement {
    @inlinable
    public var _substatement: String { value }
}

extension IndexName: ExpressibleByStringLiteral {
    @inlinable
    public init(stringLiteral: String) {
        self.init(value: stringLiteral)
    }
}
