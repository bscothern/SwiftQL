//
//  TriggerName.swift
//  SwiftQL
//
//  Created by Braden Scothern on 3/19/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct TriggerName: Name {
    public let value: String
    
    @inlinable
    public var _substatement: String { value }
    
    @inlinable
    public init(_ value: String) {
        self.value = value
    }
}

extension TriggerName: ExpressibleByStringLiteral {
    @inlinable
    public init(stringLiteral: String) {
        self.init(stringLiteral)
    }
}
