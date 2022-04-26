# blejzer

Gem for simple and compact serialization of Ruby objects into binary format. This is a toy implementation, so you may find many limitations. In simple examples you won't need to describe the types when serializing, but with complex nested types you will all have to describe the types using abstract eDSL. 

Example of structure serialization:
```ruby
require 'blejzer'

Person = Struct.new(:name, :age)

artyom = Person.new('Артём', 17)

p Blejzer(artyom) #=> binary...
```

TO-DO:

- [x] Integer
- [x] Array
- [ ] Optimized array
- [x] CString
- [x] Struct
- [ ] Class(Object)
