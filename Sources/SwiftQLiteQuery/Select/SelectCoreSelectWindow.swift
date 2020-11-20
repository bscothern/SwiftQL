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
    
    @usableFromInline
    let name: WindowName
    
    @usableFromInline
    let partitionBy: [Expression]
    
    @usableFromInline
    let orderBy: [OrderingTerm]
    
    @usableFromInline
    let frameSpec: FrameSpec?
    
    @usableFromInline
    init(_ base: SelectCoreSelectGroupExtendableStatement, name: WindowName, partitionBy: [Expression], orderBy: [OrderingTerm], frameSpec: FrameSpec?) {
        self.base = base
        self.name = name
        self.partitionBy = partitionBy
        self.orderBy = orderBy
        self.frameSpec = frameSpec
    }
}
