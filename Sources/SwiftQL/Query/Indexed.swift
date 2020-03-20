//
//  Indexed.swift
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

/// https://www.sqlite.org/lang_indexedby.html
public struct Indexed: Substatement {
    public let _substatement: String

    @usableFromInline
    init(_ _substatement: String) {
        self._substatement = _substatement
    }

    public static func by(_ name: String) -> Self {
        Self("INDEXED BY \(name)")
    }
    
    public static func not() -> Self {
        Self("NOT INDEXED")
    }
}
