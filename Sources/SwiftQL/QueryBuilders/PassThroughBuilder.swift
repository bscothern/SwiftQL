//
//  PassThroughBuilder.swift
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

@_functionBuilder
struct PassThroughBuilder<T> {
    static func buildBlock(_ components: T...) -> [T] {
        components
    }
}
