//
//  ArrayBuilder.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 1/30/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@_functionBuilder
public enum ArrayBuilder<T> {
    @inlinable
    public static func buildBlock(_ components: T) -> [T] {
        [components]
    }

    @inlinable
    public static func buildBlock(_ components: T...) -> [T] {
        components
    }
}
