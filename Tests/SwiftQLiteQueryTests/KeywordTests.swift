//
//  KeywordTests.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/24/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftQLiteQuery
import XCTest

final class KeywordTests: XCTestCase {
    func testKeywordCount() {
        XCTAssertEqual(Keyword.values.count, 145)
    }
}
