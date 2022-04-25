# blejzer

Gem for simple and compact serialization of Ruby objects into binary format. A toy implementation, so you may find many limitations.

Example of structure serialization:
```ruby
require 'blejzer'

Person = Struct.new(:name, :age)

artyom = Person.new('Артём', 17)

p Blejzer(artyom) #=> binary...
```

