//
//  Select.swift
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

public protocol SelectStatement: Statement {}
public protocol CompoundableSelectStatement: SelectStatement {}
public protocol OrderableSelectStatement: CompoundableSelectStatement {}
public protocol LimitSelectStatement: CompoundableSelectStatement {}

public protocol SelectCoreStatement: SelectOrderedByExtendableStatement {}
// The heirarchy of these Select protocols starts more refiend and ends up less refined.
// This makes it so functionality can be removed at each step as the flow allows you to do less things the further you have progressed.

public protocol SelectCoreSelectStatement: SelectCoreSelectFromExtendableStatement {}
public protocol SelectCoreSelectFromExtendableStatement: SelectCoreSelectWhereExtendableStatement {}
public protocol SelectCoreSelectWhereExtendableStatement: SelectCoreSelectGroupExtendableStatement {}
public protocol SelectCoreSelectGroupExtendableStatement: SelectCoreSelectWindowExtendableStatement {}
public protocol SelectCoreSelectWindowExtendableStatement: SelectCoreStatement {}

public protocol SelectOrderedByExtendableStatement: SelectLimitExtendableStatement {}
public protocol SelectLimitExtendableStatement: SelectStatement {}

public struct Select: OrderableSelectStatement, LimitSelectStatement {
    @inlinable
    public var statementValue: String { "" }

    @usableFromInline
    let base: SelectCoreStatement
}

//extension SelectCoreSelectStatement {
//    func from() -> some SelectCoreSelectFromExtendableStatement {
//    }
//}

extension SelectCoreSelectFromExtendableStatement {
    func `where`(expression: Expression) -> some SelectCoreSelectWhereExtendableStatement {
        SelectCoreSelectWhere(self, expression: expression)
    }
}

// TODO: Should these be called groupBy because the first trailing closure is removed in Swift 5.3?
extension SelectCoreSelectWhereExtendableStatement {
    @inlinable
    public func group(@PassThroughBuilder<Expression> by expressions: () -> [Expression]) -> some SelectCoreSelectGroupExtendableStatement {
        group(by: expressions(), having: nil)
    }

    @inlinable
    public func group(@PassThroughBuilder<Expression> by expressions: () -> [Expression], having havingExpression: () -> Expression) -> some SelectCoreSelectGroupExtendableStatement {
        group(by: expressions(), having: havingExpression())
    }

    @inlinable
    public func group(@PassThroughBuilder<Expression> by expressions: () -> [Expression], having havingExpression: Expression) -> some SelectCoreSelectGroupExtendableStatement {
        group(by: expressions(), having: havingExpression)
    }

    @inlinable
    public func group(by expressions: Expression...) -> some SelectCoreSelectGroupExtendableStatement {
        group(by: expressions, having: nil)
    }

    @inlinable
    public func group(by expressions: Expression..., having havingExpression: Expression) -> some SelectCoreSelectGroupExtendableStatement {
        group(by: expressions, having: havingExpression)
    }

    @inlinable
    public func group(by expressions: [Expression]) -> some SelectCoreSelectGroupExtendableStatement {
        group(by: expressions, having: nil)
    }

    @inlinable
    public func group(by expressions: [Expression], having havingExpression: Expression?) -> some SelectCoreSelectGroupExtendableStatement {
        SelectCoreSelectGroup(self, expressions: expressions, havingExpression: havingExpression)
    }
}

//extension SelectCoreSelectGroupExtendableStatement {
//    func window() -> some SelectCoreSelectWindowExtendableStatement {
//    }
//}

extension SelectCoreStatement {
    @inlinable
    public func union(_ select: SelectStatement) -> some SelectStatement {
        SelectUnionOperator(self, operator: .union, with: select)
    }

    @inlinable
    public func unionAll(_ select: SelectStatement) -> some SelectStatement {
        SelectUnionOperator(self, operator: .unionAll, with: select)
    }

    @inlinable
    public func intersect(_ select: SelectStatement) -> some SelectStatement {
        SelectUnionOperator(self, operator: .interset, with: select)
    }

    @inlinable
    public func except(_ select: SelectStatement) -> some SelectStatement {
        SelectUnionOperator(self, operator: .except, with: select)
    }
}

extension SelectOrderedByExtendableStatement {
    @inlinable
    public func order(@PassThroughBuilder<Expression> by orderingTerms: () -> [OrderingTerm]) -> some SelectLimitExtendableStatement {
        order(by: orderingTerms())
    }

    @inlinable
    public func order(by orderingTerms: OrderingTerm...) -> some SelectLimitExtendableStatement {
        order(by: orderingTerms)
    }

    @inlinable
    public func order(by orderingTerms: [OrderingTerm]) -> some SelectLimitExtendableStatement {
        SelectOrderBy(self, orderingTerms: orderingTerms)
    }
}

extension SelectLimitExtendableStatement {
    @inlinable
    public func limit(_ expression: Expression) -> some SelectStatement {
        SelectLimit(self, expression: expression, offset: false, expression2: nil)
    }

    @inlinable
    public func limit(_ expression: Expression, offset offsetExpression: Expression) -> some SelectStatement {
        SelectLimit(self, expression: expression, offset: true, expression2: offsetExpression)
    }

    @inlinable
    public func limie(_ expression1: Expression, _ expression2: Expression) -> some SelectStatement {
        SelectLimit(self, expression: expression2, offset: false, expression2: expression2)
    }
}
