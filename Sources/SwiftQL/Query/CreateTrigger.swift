//
//  CreateTrigger.swift
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

public struct CreateTrigger: Statement {
    @inlinable
    public var _statement: String {
        let isTemporary = self.isTemporary ? " TEMP" : ""
        let ifNotExists = self.ifNotExists ? " IF NOT EXISTS" : ""
        let schemaName = self.schemaName.map { "\($0)." } ?? ""
        let name = self.name
        let applicationTime = self.applicationTime.map { " \($0)" } ?? ""
        let action = self.action
        let tableName = self.tableName
        let forEachRow = self.forEachRow ? " FOR EACH ROW" : ""
        let when = self.when.map { " WHEN \($0)" } ?? ""
        let transactions = self.transactions.map { "\($0); " }.joined()
        return "CREATE\(isTemporary) TRIGGER\(ifNotExists) \(schemaName)\(name)\(applicationTime) \(action) ON \(tableName)\(forEachRow)\(when) BEGIN\(transactions) END"
    }

    @usableFromInline
    let name: String

    @usableFromInline
    let schemaName: String?

    @usableFromInline
    let isTemporary: Bool

    @usableFromInline
    let ifNotExists: Bool

    @usableFromInline
    let applicationTime: ApplicationTime?

    @usableFromInline
    let action: Action

    @usableFromInline
    let tableName: String

    @usableFromInline
    let forEachRow: Bool

    @usableFromInline
    let when: Expression?

    @usableFromInline
    let transactions: [TriggerTransaction]

    #warning("This needs to be cleaned up")
    public init(name: String, schemaName: String? = nil, isTemporary: Bool = false, ifNotExists: Bool = true, applicationTime: ApplicationTime?, action: Action, tableName: String, forEachRow: Bool = false, when: Expression, transactions: [TriggerTransaction]) {
        self.name = name
        self.schemaName = schemaName
        self.isTemporary = isTemporary
        self.ifNotExists = ifNotExists
        self.applicationTime = applicationTime
        self.action = action
        self.tableName = tableName
        self.forEachRow = forEachRow
        self.when = when
        self.transactions = transactions
    }
}

extension CreateTrigger {
    public enum ApplicationTime: Substatement {
        case before
        case after
        case insteadOf

        @inlinable
        public var _substatement: String {
            switch self {
            case .before:
                return "BEFORE"
            case .after:
                return "AFTER"
            case .insteadOf:
                return "INSTEAD OF"
            }
        }
    }
}

extension CreateTrigger {
    public struct Action: Substatement {
        public let _substatement: String

        @usableFromInline
        init(_ substatement: String) {
            self._substatement = substatement
        }

        public static func delete() -> Self {
            .init("DELETE")
        }

        public static func insert() -> Self {
            .init("INSERT")
        }

        public static func update() -> Self {
            .init("UPDATE")
        }

        //FIXME: Don't be string based
        public static func update(of columnNames: [String]) -> Self {
            .init("UPDATE OF \(columnNames.joined(separator: ", "))")
        }
    }
}

public protocol TriggerTransaction: Statement {}

extension Update: TriggerTransaction {}
extension Insert: TriggerTransaction {}
extension Delete: TriggerTransaction {}
extension Select: TriggerTransaction {}
