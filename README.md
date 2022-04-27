# blejzer

Gem for simple and compact serialization of Ruby objects into binary format. This is a toy implementation, so you may find many limitations. In simple examples you won't need to describe the types when serializing, but with complex nested types you will all have to describe the types using abstract eDSL. 

Example of structure serialization:
```ruby
require 'blejzer'

Person = Struct.new(:name, :age)

artyom = Person.new('Артём', 17)

p Blejzer(artyom) #=> binary...
```

A more complicated example:
```ruby
require 'blejzer'

Point = Struct.new(:x, :y)
Square = Struct.new(:point, :size)

square = Square.new(Point.new(2, -7), 6)

bin = Blejzer(square)

p Square.typed(Point, Blejzer::Auto)[bin]
```
Compared to Marshal:
```ruby
# TODO: rewrite after optimization.
p Blejzer(square).size #=> 16
p Marshal.dump(square).size #=> 46
```

TO-DO:

- [x] Integer
- [x] Nil 
- [x] Bool 
- [x] Array
- [ ] Optimized array
- [x] CString
- [x] Struct
- [ ] Hash???
- [x] Class(Object)(Maybe)
- [ ] Custom specific types by user???
