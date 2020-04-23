//
//  CommitTransaction.swift
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

public struct CommitTransaction: Statement {
    public let statementValue: String = "COMMIT TRANSACTION"

    @inlinable
    public init() {}
}
