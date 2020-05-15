//
//  ExpressionLiteral.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 4/22/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct ExpressionLiteral: ExpressionSubstatement {
    @usableFromInline
    var substatementValue: String { "\(value)" }

    @usableFromInline
    let value: Literal

    @usableFromInline
    init(_ value: Literal) {
        self.value = value
    }
}
