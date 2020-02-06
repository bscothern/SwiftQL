//
//  Literal.swift
//  SwiftQL
//
//  Created by Braden Scothern on 2/4/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLLinux
#else
import SQLite3
#endif

#if canImport(Foundation)
import Foundation
#endif

public struct Literal: Substatement {
    public let _substatement: String

    @usableFromInline
    init(_ substatement: String) {
        self._substatement = substatement
    }

    @inlinable
    public static func numeric<Numeral>(_ value: Numeral) -> Self where Numeral: Numeric {
        .init("\(value)")
    }

    @inlinable
    public static func string(_ value: String) -> Self {
        .init("'\(value)'")
    }

    @inlinable
    public static func blob(_ value: [UInt8]) -> Self {
        let blob = value.lazy
            .map {
                String($0, radix: 2)
            }.joined()
        return .init("x'\(blob)'")
    }

    #if canImport(Foundation)
    @inlinable
    public static func blob(_ value: Data) -> Self {
        let blob = value.lazy
            .map {
                String($0, radix: 2)
            }.joined()
        return .init("x'\(blob)'")
    }
    #endif

    @inlinable
    public static var null: Self { .init("NULL") }

    @inlinable
    public static var `true`: Self { .init("TRUE") }

    @inlinable
    public static var `false`: Self { .init("FALSE") }

    @inlinable
    public static var currentTime: Self { .init("CURRENT_TIME") }

    @inlinable
    public static var currentData: Self { .init("CURRENT_DATE") }

    @inlinable
    public static var currentTimestamp: Self { .init("CURRENT_TIMESTAMP") }
}
