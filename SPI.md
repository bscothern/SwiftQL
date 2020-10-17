# SPI - System Programming Interfaces
These are special components that must be explicitly requested when importing a module.
The use of SPIs is considered the use of an experimental Swift 5.3+ feature.

It is not recommended that you use these components unless you really need to.

For more information about SPIs see this PR on Swift itself: https://github.com/apple/swift/pull/29810 and this tweet from Doug on the Swift core team: https://twitter.com/dgregor79/status/1275805785247739904

## `SQLiteDebugging`
This allows access to interfaces that are used for debugging SQLite itself.
The components are only available if SQLite is built with `SQLITE_DEBUG` as a compile time option.
