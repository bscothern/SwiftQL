//
//  Expression.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 2/4/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

public protocol ExpressionSubstatement: Substatement {}

#warning("IMPLIMENT")
public struct Expression: ExpressionSubstatement {
    @inlinable
    public var substatementValue: String { "\(base)" }
    
    @usableFromInline
    let base: ExpressionSubstatement

    @inlinable
    public init(literal: Literal) {
        base = ExpressionLiteral(literal)
    }
    
    // TODO: Bind parameter
    
    @inlinable
    public init(columnName: ColumnName) {
        base = ExpressionSchemaTableColumnName(schemaName: nil, tableName: nil, columnName: columnName)
    }
    
    @inlinable
    public init(tableName: TableName, columnName: ColumnName) {
        base = ExpressionSchemaTableColumnName(schemaName: nil, tableName: tableName, columnName: columnName)
    }
    
    @inlinable
    public init(schemaName: SchemaName, tableName: TableName, columnName: ColumnName) {
        base = ExpressionSchemaTableColumnName(schemaName: schemaName, tableName: tableName, columnName: columnName)
    }
    
    // TODO: Unary-operator

    // TODO: binary operator
    
    // TODO: function-name
    
    @inlinable
    public init(@PassThroughBuilder<ExpressionSubstatement> list: () -> [ExpressionSubstatement]) {
        base = ExpressionList(list())
    }
}
