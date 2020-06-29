//
//  DropViewTests.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 6/29/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftQLiteQuery
import XCTest

final class DropViewTests: XCTestCase {
    let viewName: ViewName = "DropView_ViewName"
    let schemaName: SchemaName = "DropView_SchemaName"

    func testInitName() {
        let dropView = DropView(name: viewName)
        XCTAssertEqual("DROP VIEW IF EXISTS \(viewName.substatementValue)", dropView.statementValue)
    }

    func testInitNameIfExists() {
        let dropView = DropView(name: viewName, ifExists: true)
        XCTAssertEqual("DROP VIEW IF EXISTS \(viewName.substatementValue)", dropView.statementValue)
    }

    func testInitNameNoIfExists() {
        let dropView = DropView(name: viewName, ifExists: false)
        XCTAssertEqual("DROP VIEW \(viewName.substatementValue)", dropView.statementValue)
    }

    func testInitSchemaNameViewName() {
        let dropView = DropView(schemaName: schemaName, name: viewName)
        XCTAssertEqual("DROP VIEW IF EXISTS \(schemaName.substatementValue).\(viewName.substatementValue)", dropView.statementValue)
    }

    func testInitSchemaNameViewNameIfExists() {
        let dropView = DropView(schemaName: schemaName, name: viewName, ifExists: true)
        XCTAssertEqual("DROP VIEW IF EXISTS \(schemaName.substatementValue).\(viewName.substatementValue)", dropView.statementValue)
    }

    func testInitSchemaNameViewNameNoIfExists() {
        let dropView = DropView(schemaName: schemaName, name: viewName, ifExists: false)
        XCTAssertEqual("DROP VIEW \(schemaName.substatementValue).\(viewName.substatementValue)", dropView.statementValue)
    }
}
