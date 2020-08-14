//
//  IndexName.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 8/14/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct ModuleName: Name {
    @inlinable
    public var substatementValue: String { value }

    public let value: String

    @inlinable
    public init(_ value: String) {
        self.value = value
    }
}
