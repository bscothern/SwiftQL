//
//  SchemaName.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 3/19/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

// TODO: Should this have functions that create other names that can build off of a schema name? They would return an instance of that struct type and they would then own their schema name so it is always used.
// I don't know enough about SQL to know if that would be good to help ensure that schema names are always used...
// This would also have the benefit of dropping the schemaName parameter from many function calls.
// Or would this impact readabilty too much?
// Maybe the other types should allow you to add a schema name to them? And if you already have then they just return self?

public struct SchemaName: Name {
    public let value: String

    @inlinable
    public var substatementValue: String { value }

    @inlinable
    public init(_ value: String) {
        self.value = value
    }
}
