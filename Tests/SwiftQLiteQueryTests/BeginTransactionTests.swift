//
//  BeginTrasactionTests.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 6/27/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftQLiteQuery
import XCTest

final class BeginTrasactionTests: XCTestCase {
    func testInit() {
        let beginTransaction = BeginTransaction()
        XCTAssertEqual("BEGIN TRANSACTION", beginTransaction.statementValue)
    }

    func testInitDeferred() {
        let beginTransaction = BeginTransaction(.deferred)
        XCTAssertEqual("BEGIN DEFERRED TRANSACTION", beginTransaction.statementValue)
    }

    func testInitImmediate() {
        let beginTransaction = BeginTransaction(.immediate)
        XCTAssertEqual("BEGIN IMMEDIATE TRANSACTION", beginTransaction.statementValue)
    }

    func testInitExclusive() {
        let beginTransaction = BeginTransaction(.exclusive)
        XCTAssertEqual("BEGIN EXCLUSIVE TRANSACTION", beginTransaction.statementValue)
    }
}
