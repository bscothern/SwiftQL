//
//  SelectCoreSelectWindow.swift
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
struct SelectCoreSelectWindow: SelectCoreSelectWindowExtendableStatement {
    @usableFromInline
    var statementValue: String { "\(base)" }

    @usableFromInline
    let base: SelectCoreSelectGroupExtendableStatement
}
