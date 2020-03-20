//
//  Or.swift
//  SwiftQL
//
//  Created by Braden Scothern on 3/19/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import Foundation

public enum Or: String, Substatement {
    @inlinable
    public var _substatement: String { rawValue }

    case rollback = "ROLLBACK"
    case abort = "ABORT"
    case replace = "REPLACE"
    case fail = "FAIL"
    case ignore = "IGNORE"
}
