# Avoiding SQL Injection

Note: This is all with very placeholder names that need bikeshedding

## Examples
*It is assumed that parameters are bound when appropriate.*

### Example Data Types
Given a DB type like this:
```swift
AwesomeDatastruct AwesomeRow: DatabaseTable {
    @UniquePrimaryKey
    var id: Int
    
    @Column
    var description: String
    
    @Column
    var counter: Int
}

let awesomeData = .init(id: 1, description: "Some String", counter: 0)
```

### Insert
It would be ideal if you could tie it to the database and say something like this:

```swift
let database: Database

...

database.insert(awesomeData)
```

This would essentially result in this SQL statement:
```SQL
INSERT INTO AwesomeData VALUES (1, 'Some String')
```


### Update with Unique Primary Key
This will also hopefully work similar to this for updates as well when working with a type that has a unique primary key:
```swift
awesomeData.description = "A different string"
database.update(awesomeData)
````

```SQL
UPDATE AwesomeData SET description = :description, counter = :counter WHERE id = :id
```


### Update without Unique Primary Key
*This section acts as if the `id` property were just a `@Column` like the other properties*
```swift
database.update(awesomeData, where: (\.$id, equals: 1))
```

This would then result in SQL like this:
```SQL
UPDATE AwesomeData SET id = :id0, description = :description, counter = :counter WHERE id = :id1
```


### Partial update with Unique Primary Key
```swift
awesomeData.counter = 42
database.update(awesomeData, columns: \.$counter)
```

Which could result in this SQL:
```SQL
UPDATE AwesomeData SET counter = :counter WHERE id = :id
```


### paritail update without Unique Primary Key
*This section acts as if the `id` property were just a `@Column` like the other properties*
```swift
awesomeData.descriptioni = "Yet another description"
database.update(awesomeData, columns: \.$desription, where: (\.$id, equals: 1))
```

## Notes on the used types
For this to behave or even work at all it probably needs variadic generics sadly. Perhaps type erasure will be able to do the job well though. If that is the case it will need to use some extra protocols and types beyond what is shown above.

Because you cannot get the names of properties from keypaths this will need to follow Apple's ArgumentParser library and use `Mirror` while looking for specific property wrappers that annotate types that work with the system. This property wrapper will need to be the keypath value accessed instead of the underlying property.

The examples that pretend to not have a unique primary key have a tuple as part of there `where` argument. This is because you need to be able to associate specific values with the property to identify the value and it is better to tie the value and property together instantly instead of as syymetric argument arrays or variadic generics when those exist. It also allows you to have a named tuple that can eb documented as is shown with the `equals:` label in the tuple.
