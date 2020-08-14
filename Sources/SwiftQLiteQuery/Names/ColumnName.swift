//
//  ColumnName.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/7/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct ColumnName: Name {
    @inlinable
    public var substatementValue: String { value }

    public let value: String

    @inlinable
    public init(_ value: String) {
        self.value = value
    }
}

// TODO: Is this good enough or should there be more than just the typealias?

/// A `ColumnName` that also is indexed in the database.
public typealias IndexedColumnName = ColumnName
