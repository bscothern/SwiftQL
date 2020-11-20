//
//  WindowName.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 10/29/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct WindowName: Name {
    @inlinable
    public var substatementValue: String { value }

    public let value: String

    @inlinable
    public init(_ value: String) {
        self.value = value
    }
}
