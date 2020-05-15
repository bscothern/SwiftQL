//
//  ExpressionBinaryOperator.swift
//  SwiftQLite
//
//  Created by Braden Scothern on 5/14/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

@usableFromInline
struct ExpressionBinaryOperator: ExpressionSubstatement {
    @usableFromInline
    var substatementValue: String { "\(lhs) \(binaryOperator.rawValue) \(rhs)" }
    
    @usableFromInline
    let lhs: Expression
    
    @usableFromInline
    let binaryOperator: Expression.BinaryOperator

    @usableFromInline
    let rhs: Expression

    @usableFromInline
    init(lhs: Expression, binaryOperator: Expression.BinaryOperator, rhs: Expression) {
        self.lhs = lhs
        self.binaryOperator = binaryOperator
        self.rhs = rhs
    }
}

// MARK: Binary Operator
precedencegroup SwiftQLiteConcatPrecedence {
    higherThan: SwiftQLiteMultaplicativePrecedence
}
infix operator .|| : SwiftQLiteConcatPrecedence

@inlinable
public func .|| (lhs: Expression, rhs: Expression) -> Expression {
    lhs.concatenate(rhs)
}

extension Expression {
    @inlinable
    public func concatenate(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .concatenate, rhs: other)
    }
}

precedencegroup SwiftQLiteMultaplicativePrecedence {
    higherThan: SwiftQLiteBitwisePrecedence
}
infix operator .* : SwiftQLiteMultaplicativePrecedence
infix operator ./ : SwiftQLiteMultaplicativePrecedence
infix operator .% : SwiftQLiteMultaplicativePrecedence

@inlinable
public func .* (lhs: Expression, rhs: Expression) -> Expression {
    lhs.multiply(by: rhs)
}

@inlinable
public func ./ (lhs: Expression, rhs: Expression) -> Expression {
    lhs.divide(by: rhs)
}

@inlinable
public func .% (lhs: Expression, rhs: Expression) -> Expression {
    lhs.mod(by: rhs)
}

extension Expression {
    @inlinable
    public func multiply(by other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .multiply, rhs: other)
    }
    
    @inlinable
    public func divide(by other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .divide, rhs: other)
    }
    
    @inlinable
    public func mod(by other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .mod, rhs: other)
    }
}

precedencegroup SwiftQLiteBitwisePrecedence {
    higherThan: SwiftQLiteComparisonPrecedence
}
infix operator .<< : SwiftQLiteBitwisePrecedence
infix operator .>> : SwiftQLiteBitwisePrecedence
infix operator .& : SwiftQLiteBitwisePrecedence
infix operator .| : SwiftQLiteBitwisePrecedence

@inlinable
public func .<< (lhs: Expression, rhs: Expression) -> Expression {
    lhs.bitShift(.left, by: rhs)
}

@inlinable
public func .>> (lhs: Expression, rhs: Expression) -> Expression {
    lhs.bitShift(.right, by: rhs)
}

@inlinable
public func .& (lhs: Expression, rhs: Expression) -> Expression {
    lhs.bitwiseAnd(rhs)
}

@inlinable
public func .| (lhs: Expression, rhs: Expression) -> Expression {
    lhs.bitwiseOr(rhs)
}

extension Expression {
    
    public enum BitShiftDirection {
        case left
        case right
        
        @usableFromInline
        var `operator`: Expression.BinaryOperator {
            switch self {
            case .left:
                return .bitShiftLeft
            case .right:
                return .bitShiftRight
            }
        }
    }
    
    @inlinable
    public func bitShift(_ direction: BitShiftDirection, by other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: direction.operator, rhs: other)
    }
    
    @inlinable
    public func bitwiseAnd(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .bitwiseAnd, rhs: other)
    }
    
    @inlinable
    public func bitwiseOr(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .bitwiseOr, rhs: other)
    }
}

precedencegroup SwiftQLiteComparisonPrecedence {
    higherThan: SwiftQLiteEqualityPrecedence
}
infix operator .< : SwiftQLiteComparisonPrecedence
infix operator .<= : SwiftQLiteComparisonPrecedence
infix operator .> : SwiftQLiteComparisonPrecedence
infix operator .>= : SwiftQLiteComparisonPrecedence

@inlinable
public func .< (lhs: Expression, rhs: Expression) -> Expression {
    lhs.lessThan(rhs)
}

@inlinable
public func .<= (lhs: Expression, rhs: Expression) -> Expression {
    lhs.lessThanOrEqual(to: rhs)
}

@inlinable
public func .> (lhs: Expression, rhs: Expression) -> Expression {
    lhs.greaterThan(rhs)
}

@inlinable
public func .>= (lhs: Expression, rhs: Expression) -> Expression {
    lhs.greaterThanOrEqual(to: rhs)
}

extension Expression {
    @inlinable
    public func lessThan(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .lessThan, rhs: other)
    }
    
    @inlinable
    public func lessThanOrEqual(to other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .lessThanOrEqual, rhs: other)
    }
    
    @inlinable
    public func greaterThan(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .greaterThan, rhs: other)
    }
    
    @inlinable
    public func greaterThanOrEqual(to other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .greaterThanOrEqual, rhs: other)
    }
}

precedencegroup SwiftQLiteEqualityPrecedence {
    higherThan: DefaultPrecedence
}
infix operator .= : SwiftQLiteEqualityPrecedence
infix operator .== : SwiftQLiteEqualityPrecedence
infix operator .!= : SwiftQLiteEqualityPrecedence
infix operator .<> : SwiftQLiteEqualityPrecedence

@inlinable
public func .= (lhs: Expression, rhs: Expression) -> Expression {
    lhs.assign(rhs)
}

@inlinable
public func .== (lhs: Expression, rhs: Expression) -> Expression {
    lhs.equals(rhs)
}

@inlinable
public func .!= (lhs: Expression, rhs: Expression) -> Expression {
    lhs.notEqual(to: rhs)
}

@inlinable
public func .<> (lhs: Expression, rhs: Expression) -> Expression {
    lhs.notEqual2(to: rhs)
}

extension Expression {
    @inlinable
    public func assign(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .assign, rhs: other)
    }
    
    @inlinable
    public func equals(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .equal, rhs: other)
    }
    
    @inlinable
    public func notEqual(to other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .notEqual, rhs: other)
    }
    
    @inlinable
    public func notEqual2(to other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .notEqual2, rhs: other)
    }
    
    @inlinable
    public func `is`(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .is, rhs: other)
    }
    
    @inlinable
    public func isNot(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .isNot, rhs: other)
    }
    
    @inlinable
    public func `in`(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .in, rhs: other)
    }
    
    @inlinable
    public func like(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .like, rhs: other)
    }
    
    @inlinable
    public func glob(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .glob, rhs: other)
    }
    
    @inlinable
    public func match(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .match, rhs: other)
    }
    
    @inlinable
    public func regexp(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .regexp, rhs: other)
    }
}

extension Expression {
    @inlinable
    public func and(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .and, rhs: other)
    }
}

extension Expression {
    @inlinable
    public func or(_ other: Expression) -> Expression {
        .init(_lhs: self, binaryOperator: .or, rhs: other)
    }
}
