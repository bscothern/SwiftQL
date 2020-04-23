//
//  PassThroughBuilder.swift
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

@_functionBuilder
public enum PassThroughBuilder<T> {
    @inlinable
    public static func buildBlock(_ components: T) -> [T] {
        [components]
    }

    @inlinable
    public static func buildBlock(_ components: T...) -> [T] {
        components
    }
}