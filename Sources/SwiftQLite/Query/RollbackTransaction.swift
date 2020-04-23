//
//  RollbackTransaction.swift
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

public struct RollbackTransaction: Statement {
    @inlinable
    public var _statement: String {
        let savepoint = self.savepoint.map { " TO \($0)"} ?? ""
        return "ROLLBACK TRANSACTION\(savepoint)"
    }

    @usableFromInline
    let savepoint: Savepoint?

    @inlinable
    public init() {
        savepoint = nil
    }

    @inlinable
    public init(to savepoint: Savepoint) {
        self.savepoint = savepoint
    }
}
