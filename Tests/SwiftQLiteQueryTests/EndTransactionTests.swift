//
//  EndTransactionTests.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 6/29/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftQLiteQuery
import XCTest

final class EndTransactionTests: XCTestCase {
    func testInit() {
        let endTransaction = EndTransaction()
        XCTAssertEqual("END TRANSACTION", endTransaction.statementValue)
    }
}
