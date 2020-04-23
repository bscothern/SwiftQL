//
//  DataType.swift
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

public enum DataType: String {
    case null = "NULL"
    case int = "INTEGER"
    case real = "REAL"
    case text = "TEXT"
    case blob = "BLOB"
}
