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

public protocol SelectCoreStatement: SelectStatement {}
// The heirarchy of these Select protocols starts more refiend and ends up less refined.
// This makes it so functionality can be removed at each step as the flow allows you to do less things the further you have progressed.

public protocol SelectCoreSelectStatement: SelectCoreSelectFromExtendableStatement {}
public protocol SelectCoreSelectFromExtendableStatement: SelectCoreSelectWhereExtendableStatement {}
public protocol SelectCoreSelectWhereExtendableStatement: SelectCoreSelectGroupExtendableStatement {}
public protocol SelectCoreSelectGroupExtendableStatement: SelectCoreSelectWindowExtendableStatement {}
public protocol SelectCoreSelectWindowExtendableStatement: SelectCoreStatement {}

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
