//
//  TriggerName.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 3/19/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct TriggerName: Name {
    public let value: String

    @inlinable
    public var substatementValue: String { value }

    @inlinable
    public init(_ value: String) {
        self.value = value
    }
}
