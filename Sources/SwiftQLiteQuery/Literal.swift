//
//  Literal.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 2/4/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

#if os(Linux)
import SwiftQLiteLinux
#else
import SQLite3
#endif

#if canImport(Foundation)
import Foundation
#endif

public struct Literal: Substatement {
    public let substatementValue: String

    @usableFromInline
    init(_ substatement: String) {
        self.substatementValue = substatement
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

// TODO: Should literal conform to these protocols?
// This would be potentially very handy but it should only be done once it can be proven it won't cause other issues.
// Adding things is always easy, taking them away is not.

//extension Literal: ExpressibleByFloatLiteral {
//    @inlinable
//    public init(floatLiteral value: Double) {
//        self = .numeric(value)
//    }
//}
//
//extension Literal: ExpressibleByIntegerLiteral {
//    @inlinable
//    public init(integerLiteral value: Int) {
//        self = .numeric(value)
//    }
//}
//
//extension Literal: ExpressibleByStringLiteral {
//    @inlinable
//    public init(stringLiteral value: String) {
//        self = .string(value)
//    }
//}
//
//
//
//extension Literal: ExpressibleByArrayLiteral {
//    @inlinable
//    public init(arrayLiteral value: UInt8...) {
//        self = .blob(value)
//    }
//}
//
//extension Literal: ExpressibleByBooleanLiteral {
//    @inlinable
//    public init(booleanLiteral value: Bool) {
//        self = value ? .true : .false
//    }
//}
