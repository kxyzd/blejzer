# blejzer

Gem для простой и компактной сериализации объектов Ruby в бинарный формат. Это игрушечная реализация, поэтому вы можете обнаружить множество ограничений. В простых примерах вам не нужно будет описывать типы при сериализации, но со сложными вложенными типами вам всё же придется это сделать.

Пример сериализации структуры:
```ruby
require 'blejzer'

Person = Struct.new(:name, :age)

artyom = Person.new('Артём', 17)

p Blejzer(artyom) #=> binary...
```

Более сложный пример:
```ruby
require 'blejzer'

Point = Struct.new(:x, :y)
Square = Struct.new(:point, :size)

square = Square.new(Point.new(2, -7), 6)

bin = Blejzer(square)

p Square.typed(Point, Blejzer::Auto)[bin]
```
По сравнению с [Marshal](https://rubyapi.org/3.1/o/marshal):
```ruby
# TODO: rewrite after optimization.
p Blejzer(square).size #=> 12
p Marshal.dump(square).size #=> 46
```
Оптимизированные массивы:
```ruby
pry(main)> Blejzer(a = 10_000.times.map { rand(10_000..50_000) }).size
20005
pry(main)> Marshal.dump(a).size
40006
```

TO-DO:
- [ ] Добавить возможность описывать рекурсивные структуры данных
- [ ] Добавить тесты
  - [x] Частично
- [ ] Рефакторинг и доп. оптимизации(мин.)
  - [x] Оптимизировано поле размера массива
  - [x] Уточнена работа метода members 
  - [ ] Много копипаста
- [ ] Написать "how to use"
- [ ] Разобраться с созданием гема
- [x] Integer
- [x] BigNumber
- [ ] Float
- [x] Nil 
- [x] Bool 
- [x] Array
- [ ] Optimized array
  - [x] Простой паттерн всех типов
  - [ ] Преобразование похожих типов в один общий большинства
- [x] CString
- [x] Struct
- [ ] Hash???
- [x] Class(Object)(Maybe)
- [ ] Custom specific types by user???
