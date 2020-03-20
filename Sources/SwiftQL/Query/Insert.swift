//
//  Insert.swift
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

public struct Insert: Statement {
    @inlinable
    public var _statement: String {
        ""
    }
    
    @usableFromInline
    let with: With
    
//    @inlinable
//    public init(or: Or? = nil, tableName: TableName, schemaName: SchemaName) {
//        
//    }
}
