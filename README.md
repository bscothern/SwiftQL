# SwiftQL

## Development Notes
Initial development will be `String` based APIs for simplicity and it will be needed to build type safety on top of since SQLite is a `String` based API anyways.

#### Nomenclature
* `base` the parent [sub]statement
* `content` used a type is "generic" in the sense it has a value that conforms to a private protocol that is the actual value of the instance.

### Needs Initial Implimentation (23/38 Complete)
[Documentation](https://www.sqlite.org/lang.html)
[ ] aggregate functions
[ ] ALTER TABLE
[X] ANALYZE
[X] ATTACH DATABASE
[X] BEGIN TRANSACTION
[ ] comment
[X] COMMIT TRANSACTION
[ ] core functions
[X] CREATE INDEX
[X] CREATE TABLE
[X] CREATE TRIGGER*
[X] CREATE VIEW*
[ ] CREATE VIRTUAL TABLE
[ ] date and time functions
[X] DELETE
[X] DETACH DATABASE
[X] DROP INDEX
[X] DROP TABLE
[X] DROP TRIGGER
[X] DROP VIEW
[X] END TRANSACTION
[ ] EXPLAIN
[ ] expression
[X] INDEXED BY
[ ] INSERT
[ ] keywords
[ X ON CONFLICT clause
[ ] PRAGMA
[X] REINDEX
[X] RELEASE SAVEPOINT
[ ] REPLACE
[X] ROLLBACK TRANSACTION
[X] SAVEPOINT
[ ] SELECT
[ ] UPDATE
[ ] UPSERT
[X] VACUUM
[X] WITH clause

`*` items need extra clean up

### Needs Test and Documentation (0/38 Complete)
[ ] aggregate functions
[ ] ALTER TABLE
[ ] ANALYZE
[ ] ATTACH DATABASE
[ ] BEGIN TRANSACTION
[ ] comment
[ ] COMMIT TRANSACTION
[ ] core functions
[ ] CREATE INDEX
[ ] CREATE TABLE
[ ] CREATE TRIGGER
[ ] CREATE VIEW
[ ] CREATE VIRTUAL TABLE
[ ] date and time functions
[ ] DELETE
[ ] DETACH DATABASE
[ ] DROP INDEX
[ ] DROP TABLE
[ ] DROP TRIGGER
[ ] DROP VIEW
[ ] END TRANSACTION
[ ] EXPLAIN
[ ] expression
[ ] INDEXED BY
[ ] INSERT
[ ] keywords
[ ] ON CONFLICT clause
[ ] PRAGMA
[ ] REINDEX
[ ] RELEASE SAVEPOINT
[ ] REPLACE
[ ] ROLLBACK TRANSACTION
[ ] SAVEPOINT
[ ] SELECT
[ ] UPDATE
[ ] UPSERT
[ ] VACUUM
[ ] WITH clause
