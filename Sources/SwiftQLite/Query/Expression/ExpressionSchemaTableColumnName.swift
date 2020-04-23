//
//  ExpressionSchemaTableColumnName.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/22/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct ExpressionSchemaTableColumnName: ExpressionSubstatement {
    @usableFromInline
    var substatementValue: String {
        let schemaName = self.schemaName.map { "\($0)." } ?? ""
        let tableName = self.tableName.map { "\($0)." } ?? ""
        return "\(schemaName)\(tableName)\(columnName)"
    }
    
    @usableFromInline
    let schemaName: SchemaName?
    
    @usableFromInline
    let tableName: TableName?
    
    @usableFromInline
    let columnName: ColumnName
    
    @usableFromInline
    init(schemaName: SchemaName?, tableName: TableName?, columnName: ColumnName) {
        self.schemaName = schemaName
        self.tableName = tableName
        self.columnName = columnName
    }
}
