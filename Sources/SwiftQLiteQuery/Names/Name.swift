//
//  IndexName.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 3/19/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public protocol Name: Substatement, Hashable, ExpressibleByStringLiteral {
    init(_ value: String)
}

extension Name {
    @inlinable
    public init(stringLiteral: String) {
        self.init(stringLiteral)
    }
}
