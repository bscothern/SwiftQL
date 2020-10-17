# SwiftQLite

## Development Notes
Initial development will be `String` based APIs for simplicity and it will be needed to build type safety on top of since SQLite is a `String` based API anyways.
This work is being done in the target `SwiftQLiteQuery`

#### Nomenclature
* `base` the parent [sub]statement
* `content` used a type is "generic" in the sense it has a value that conforms to a private protocol that is the actual value of the instance.

### Needs Initial Implimentation (31/38 Complete)
[Documentation](https://www.sqlite.org/lang.html)
* [ ] aggregate functions
* [X] ALTER TABLE
* [X] ANALYZE
* [X] ATTACH DATABASE
* [X] BEGIN TRANSACTION
* [X] ~comment~ (Comments should live in the swift code building the queries instead of in the actual queries)
* [X] COMMIT TRANSACTION
* [ ] core functions
* [X] CREATE INDEX
* [X] CREATE TABLE
* [X] CREATE TRIGGER*
* [X] CREATE VIEW*
* [X] CREATE VIRTUAL TABLE
* [ ] date and time functions
* [X] DELETE
* [X] DETACH DATABASE
* [X] DROP INDEX
* [X] DROP TABLE
* [X] DROP TRIGGER
* [X] DROP VIEW
* [X] END TRANSACTION
* [X] EXPLAIN
* [ ] expression
* [X] INDEXED BY
* [X] INSERT
* [X] keywords
* [X] ON CONFLICT clause
* [ ] PRAGMA
* [X] REINDEX
* [X] RELEASE SAVEPOINT
* [X] REPLACE
* [X] ROLLBACK TRANSACTION
* [X] SAVEPOINT
* [ ] SELECT
* [X] UPDATE
* [X] UPSERT
* [X] VACUUM
* [X] WITH clause

`*` items need extra clean up

### Needs Test (14/38 Complete)
* [ ] aggregate functions
* [X] ALTER TABLE	
* [X] ANALYZE
* [X] ATTACH DATABASE
* [X] BEGIN TRANSACTION
* [X] ~comment~ (Comments should live in the swift code building the queries instead of in the actual queries)
* [X] COMMIT TRANSACTION
* [ ] core functions
* [X] CREATE INDEX
* [ ] CREATE TABLE
* [ ] CREATE TRIGGER
* [ ] CREATE VIEW
* [ ] CREATE VIRTUAL TABLE
* [ ] date and time functions
* [ ] DELETE
* [X] DETACH DATABASE
* [X] DROP INDEX
* [X] DROP TABLE
* [X] DROP TRIGGER
* [X] DROP VIEW
* [X] END TRANSACTION
* [ ] EXPLAIN
* [ ] expression
* [ ] INDEXED BY
* [ ] INSERT
* [X] keywords
* [ ] ON CONFLICT clause
* [ ] PRAGMA
* [ ] REINDEX
* [ ] RELEASE SAVEPOINT
* [ ] REPLACE
* [ ] ROLLBACK TRANSACTION
* [ ] SAVEPOINT
* [ ] SELECT
* [ ] UPDATE
* [ ] UPSERT
* [ ] VACUUM
* [ ] WITH clause

### Needs Documentation (1/38 Complete)
* [ ] aggregate functions
* [ ] ALTER TABLE
* [ ] ANALYZE
* [ ] ATTACH DATABASE
* [ ] BEGIN TRANSACTION
* [X] ~comment~ (Comments should live in the swift code building the queries instead of in the actual queries)
* [ ] COMMIT TRANSACTION
* [ ] core functions
* [ ] CREATE INDEX
* [ ] CREATE TABLE
* [ ] CREATE TRIGGER
* [ ] CREATE VIEW
* [ ] CREATE VIRTUAL TABLE
* [ ] date and time functions
* [ ] DELETE
* [ ] DETACH DATABASE
* [ ] DROP INDEX
* [ ] DROP TABLE
* [ ] DROP TRIGGER
* [ ] DROP VIEW
* [ ] END TRANSACTION
* [ ] EXPLAIN
* [ ] expression
* [ ] INDEXED BY
* [ ] INSERT
* [ ] keywords
* [ ] ON CONFLICT clause
* [ ] PRAGMA
* [ ] REINDEX
* [ ] RELEASE SAVEPOINT
* [ ] REPLACE
* [ ] ROLLBACK TRANSACTION
* [ ] SAVEPOINT
* [ ] SELECT
* [ ] UPDATE
* [ ] UPSERT
* [ ] VACUUM
* [ ] WITH clause

