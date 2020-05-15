//
//  SelectCoreSelect.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/24/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

@usableFromInline
struct SelectCoreSelect: SelectCoreSelectStatement {
    @usableFromInline
    var statementValue: String { "" }

    @usableFromInline
    let category: Select.Category

    @usableFromInline
    let resultColumns: [ColumnName]
}
