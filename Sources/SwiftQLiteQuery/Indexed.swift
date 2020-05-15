//
//  Indexed.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 1/30/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

/// https://www.sqlite.org/lang_indexedby.html
public struct Indexed: Substatement {
    public let substatementValue: String

    @usableFromInline
    init(_ _substatement: String) {
        self.substatementValue = _substatement
    }

    public static func by(_ name: String) -> Self {
        Self("INDEXED BY \(name)")
    }

    public static func not() -> Self {
        Self("NOT INDEXED")
    }
}
