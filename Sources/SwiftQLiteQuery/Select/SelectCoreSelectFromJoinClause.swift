//
//  SelectCoreSelectFromJoinClause.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 10/29/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

@usableFromInline
struct SelectCoreSelectFromJoinClause: SelectCoreSelectFromExtendableStatement {
    @usableFromInline
    var statementValue: String { "\(base)" }

    @usableFromInline
    let base: SelectCoreSelectStatement
}
