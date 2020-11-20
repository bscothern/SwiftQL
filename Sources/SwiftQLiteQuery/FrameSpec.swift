//
//  FrameSpec.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 10/29/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct FrameSpec: Substatement {
    @usableFromInline
    enum Category: String, FrameSpecCategory {
        case range = "RANGE"
        case rows = "ROWS"
        case groups = "GROUPS"
    }
    
    @inlinable
    static var range: some FrameSpecCategory { Category.range }
    @inlinable
    static var rows: some FrameSpecCategory { Category.rows }
    @inlinable
    static var groups: some FrameSpecCategory { Category.groups }
    
    @inlinable
    public var substatementValue: String { "" }
}

public protocol FrameSpecCategory {}
public protocol FrameSpecBetween {}
public protocol FrameSpecExclude: Substatement {
    
}

