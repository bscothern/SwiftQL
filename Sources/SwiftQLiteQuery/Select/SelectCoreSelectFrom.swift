//
//  SelectCoreSelectFrom.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/26/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

@usableFromInline
struct SelectCoreSelectFrom: SelectCoreSelectFromExtendableStatement {
    @usableFromInline
    var statementValue: String { "\(base)" }

    @usableFromInline
    let base: SelectCoreSelect
}
