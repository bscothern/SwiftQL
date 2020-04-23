import SwiftQLite
import XCTest

final class AnalyzeSyntaxTests: XCTestCase {
    func testInitSchema() {
        let schemaName: SchemaName = "testInitSchema"
        let analyze = Analyze(schemaName: schemaName)
        XCTAssertEqual("ANALYZE testInitSchema", analyze._statement)
    }

    func testInitTable() {
        let tableName: TableName = "testInitTable"
        let analyze = Analyze(tableName: tableName)
        XCTAssertEqual("ANALYZE testInitTable", analyze._statement)
    }

    func testInitIndex() {
        let indexName: IndexName = "testInitIndex"
        let analyze = Analyze(indexName: indexName)
        XCTAssertEqual("ANALYZE testInitIndex", analyze._statement)
    }

    func testInitSchemaTable() {
        let schemaName: SchemaName = "testInitSchemaTable_schema"
        let tableName: TableName = "testInitSchemaTable_table"
        let analyze = Analyze(schemaName: schemaName, tableName: tableName)
        XCTAssertEqual("ANALYZE testInitSchemaTable_schema.testInitSchemaTable_table", analyze._statement)
    }

    func testInitSchemaIndex() {
        let schemaName: SchemaName = "testInitSchemaIndex_schema"
        let indexName: IndexName = "testInitSchemaIndex_index"
        let analyze = Analyze(schemaName: schemaName, indexName: indexName)
        XCTAssertEqual("ANALYZE testInitSchemaIndex_schema.testInitSchemaIndex_index", analyze._statement)
    }
}
