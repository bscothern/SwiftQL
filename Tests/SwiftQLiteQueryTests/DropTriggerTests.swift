//
//  DropTriggerTests.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 6/29/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftQLiteQuery
import XCTest

final class DropTriggerTests: XCTestCase {
    let triggerName: TriggerName = "DropTrigger_TriggerName"
    let schemaName: SchemaName = "DropTrigger_SchemaName"

    func testInitName() {
        let dropTrigger = DropTrigger(name: triggerName)
        XCTAssertEqual("DROP TRIGGER IF EXISTS \(triggerName.substatementValue)", dropTrigger.statementValue)
    }

    func testInitNameIfExists() {
        let dropTrigger = DropTrigger(name: triggerName, ifExists: true)
        XCTAssertEqual("DROP TRIGGER IF EXISTS \(triggerName.substatementValue)", dropTrigger.statementValue)
    }

    func testInitNameNoIfExists() {
        let dropTrigger = DropTrigger(name: triggerName, ifExists: false)
        XCTAssertEqual("DROP TRIGGER \(triggerName.substatementValue)", dropTrigger.statementValue)
    }

    func testInitSchemaNameTriggerName() {
        let dropTrigger = DropTrigger(schemaName: schemaName, name: triggerName)
        XCTAssertEqual("DROP TRIGGER IF EXISTS \(schemaName.substatementValue).\(triggerName.substatementValue)", dropTrigger.statementValue)
    }

    func testInitSchemaNameTriggerNameIfExists() {
        let dropTrigger = DropTrigger(schemaName: schemaName, name: triggerName, ifExists: true)
        XCTAssertEqual("DROP TRIGGER IF EXISTS \(schemaName.substatementValue).\(triggerName.substatementValue)", dropTrigger.statementValue)
    }

    func testInitSchemaNameTriggerNameNoIfExists() {
        let dropTrigger = DropTrigger(schemaName: schemaName, name: triggerName, ifExists: false)
        XCTAssertEqual("DROP TRIGGER \(schemaName.substatementValue).\(triggerName.substatementValue)", dropTrigger.statementValue)
    }
}
