//
//  Select.swift
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

public protocol SelectStatement: Statement {}
public protocol CompoundableSelectStatement: SelectStatement {}
public protocol OrderableSelectStatement: CompoundableSelectStatement {}
public protocol LimitSelectStatement: CompoundableSelectStatement {}

public protocol SelectCoreStatement: SelectStatement {}
public protocol SelectCoreSelectStatement: SelectCoreStatement {}

public protocol SelectCoreSelectWindowExtendableStatement: SelectStatement {}
public protocol SelectCoreSelectGroupExtendableStatement: SelectCoreSelectWindowExtendableStatement {}
public protocol SelectCoreSelectWhereExtendableStatement: SelectCoreSelectGroupExtendableStatement {}
public protocol SelectCoreSelectFromExtendableStatement: SelectCoreSelectWhereExtendableStatement {}

public struct Select: OrderableSelectStatement, LimitSelectStatement {
    public enum Category: String {
        case all = "ALL"
        case distinct = "DISTINCT"
    }

    @inlinable
    public var statementValue: String { "" }

    @usableFromInline
    let base: SelectCoreStatement
}

extension SelectCoreSelectStatement {
}
