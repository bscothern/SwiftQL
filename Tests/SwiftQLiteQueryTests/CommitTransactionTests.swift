//
//  CommitTransactionTests.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 6/27/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftQLiteQuery
import XCTest

final class CommitTransactionTests: XCTestCase {
    func testInit() {
        let commitTransaction = CommitTransaction()
        XCTAssertEqual("COMMIT TRANSACTION", commitTransaction.statementValue)
    }
}
