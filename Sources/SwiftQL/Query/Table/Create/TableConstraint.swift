//
//  TableConstraint.swift
//  SwiftQL
//
//  Created by Braden Scothern on 2/3/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLLinux
#else
import SQLite3
#endif

public protocol TableConstraintProtocol: _Substatement {}

public struct TableConstraint: _Substatement {
    public var substatement: String {
        name.map { " CONSTRAINT \($0)" } ?? ""
    }
    
    @usableFromInline let name: String?
    
    public init(name: String? = nil) {
        self.name = name
    }
    
    #warning("Don't take Strings directly.")
    public func primaryKey(indexedColumns: [String], onConflict: ConflictClause? = nil) -> some TableConstraintProtocol {
        TableConstraintPrimaryKeyOrUnique(type: .primaryKey, with: self, indexedColumns: indexedColumns, onConflict: onConflict)
    }
    
    #warning("Don't take Strings directly.")
    public func unique(indexedColumns: [String], onConflict: ConflictClause? = nil) -> some TableConstraintProtocol {
        TableConstraintPrimaryKeyOrUnique(type: .unique, with: self, indexedColumns: indexedColumns, onConflict: onConflict)
    }
    
    public func check() -> some TableConstraintProtocol {
        TableConstraintCheck(self)
    }
    
    #warning("Don't take Strings directly.")
    public func foreignKey(columns: [String], foreignKey: ForeignKey) -> some TableConstraintProtocol {
        TableConstraintForeignKey(self)
    }
}

@usableFromInline
struct TableConstraintPrimaryKeyOrUnique: TableConstraintProtocol {
    @usableFromInline
    enum Classification: String {
        case primaryKey = "PRIMARY KEY"
        case unique = "UNIQUE"
    }
    
    public var substatement: String {
        let classification = self.classification.rawValue
        let indexedColumns = self.indexedColumns.joined(separator: ", ")
        let onConflict = self.onConflict?.substatement ?? ""
        return "\(base.substatement) \(classification) (\(indexedColumns))\(onConflict)"
    }
    
    @usableFromInline let base: TableConstraint
    @usableFromInline let classification: Classification
    @usableFromInline let indexedColumns: [String]
    @usableFromInline let onConflict: ConflictClause?
    
    @usableFromInline
    init(type classification: Classification, with base: TableConstraint, indexedColumns: [String], onConflict: ConflictClause?) {
        self.base = base
        self.classification = classification
        self.indexedColumns = indexedColumns
        self.onConflict = onConflict
    }
}

@usableFromInline
struct TableConstraintCheck: TableConstraintProtocol {
    public var substatement: String {
        let expression = ""
        return "\(base.substatement) CHECK (\(expression))"
    }
    
    @usableFromInline let base: TableConstraint
    
    @usableFromInline
    init(_ base: TableConstraint) {
        self.base = base
    }
}

@usableFromInline
struct TableConstraintForeignKey: TableConstraintProtocol {
    public var substatement: String {
        "\(base.substatement) FOREIGN KEY"
    }
    
    @usableFromInline let base: TableConstraint
    
    @usableFromInline
    init(_ base: TableConstraint) {
        self.base = base
    }
}
