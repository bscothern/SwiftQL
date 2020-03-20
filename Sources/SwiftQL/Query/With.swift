//
//  With.swift
//  SwiftQL
//
//  Created by Braden Scothern on 1/30/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLLinux
#else
import SQLite3
#endif

public struct With: Substatement {
    @inlinable
    public var _substatement: String {
        let recursive = self.recursive ? " RECURSIVE" : ""
        let commonTableExpressions = self.commonTableExpressions.joined(separator: ", ")
        return "WITH\(recursive) \(commonTableExpressions)"
    }

    @usableFromInline
    let recursive: Bool

    @usableFromInline
    let commonTableExpressions: [String]

    @inlinable
    public init(recursive: Bool = false, @PassThroughBuilder<String> commonTableExpressions: () -> [String]) {
        self.recursive = recursive
        self.commonTableExpressions = commonTableExpressions()
    }
}
