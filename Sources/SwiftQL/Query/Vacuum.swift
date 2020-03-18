//
//  Vacuum.swift
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

/// https://www.sqlite.org/lang_vacuum.html
public struct Vacuum: Statement {
    public var _statement: String {
        let schemaName = self.schemaName.map { " \($0)" } ?? ""
        let fileName = self.fileName.map { " INTO \($0)" } ?? ""
        return "VACUUM\(schemaName)\(fileName)"
    }

    @usableFromInline
    let schemaName: String?

    @usableFromInline
    let fileName: String?

    public init() {
        self.init(schemaName: nil, into: nil)
    }

    public init(schemaName: String?) {
        self.init(schemaName: schemaName, into: nil)
    }

    public init(into fileName: String?) {
        self.init(schemaName: nil, into: fileName)
    }

    public init(schemaName: String?, into fileName: String?) {
        self.schemaName = schemaName
        self.fileName = fileName
    }
}
