//
//  BeginTransaction.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 1/30/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

public struct BeginTransaction: Statement {
    public enum Behavior: String {
        case deferred = "DEFERRED"
        case immediate = "IMMEDIATE"
        case exclusive = "EXCLUSIVE"
    }

    @inlinable
    public var statementValue: String { "BEGIN \(behavior.map { "\($0.rawValue) "} ?? "")TRANSACTION" }

    @usableFromInline
    let behavior: Behavior?

    @inlinable
    public init() {
        behavior = nil
    }

    @inlinable
    public init(_ behavior: Behavior) {
        self.behavior = behavior
    }
}
