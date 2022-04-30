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
pry(main)> Blejzer::UOArray.new(a).dump.size
30004
pry(main)> Marshal.dump(a).size
40006
```

###  Как этим пользоваться?

Для сериализации и десириализации используется метод `Blejzer()`.  Если передать строку, то произойдёт десириализация, иначе если передать другой объект - сериализация. 
```ruby
...
pry(main)> bin = Blejzer(12345)
=> "\x0290"
pry(main)> Blejzer(bin)
=> 12345
```
Для сериализации пользовательских типов объект должен реализовывать метод members, возвращающий массив символов, обозначающие имена инстантс-переменных. 
```ruby
class Book
  attr_reader :title, :author, ...
  members :title, :author, ...
  ...
end
```  
Для это вы можете воспользоваться вспомогательном методом `members`, что генерирует такой метод. 

Классы, созданные с помощью [Struct](https://rubyapi.org/3.1/o/struct), не нуждаются в подобных ухищрениях. 

Для десириализации ваших объектов используйте метод класса `#from`, принимающий строку в качестве аргумента.
```ruby
...
pry(main)> book = Book.new(...)
pry(main)> bin = Blejzer(book)
pry(main)> Book.from(bin)
=> ...
```
А если ваши объекты внутри имеют другие объекты, то воссоздать структуру можно с помощью описания типов:
```ruby
Square.typed(
	Point, 
	Blejzer::Auto
)[bin]
```
Запись `Blejzer::Auto` или `Blejzer::Any` оставляет элемент(объект) на откуп blejzer'у. Стоит учитывать, все сложные объекты представляются в виде массива!

Если вам необходимо описать более глубокую вложенность, то воспользуйтесь методом `#type`:
```ruby
A.typed(
	Blejzer::Auto,
	B.type(C, Blejzer::Auto, D)
)[bin]
```
На данный момент нет возможности описывать рекурсивные структуры данных, вам надо будет делать это вручную, смотрите [пример](https://github.com/kxyzd/blejzer/blob/ebc2f192a582d3f310d332b9e23c657d5d7f68c5/spec/struct_spec.rb#L59). 

---

TO-DO:
- [ ] Добавить возможность описывать рекурсивные структуры данных
- [ ]  Добавить возможность описывать типы до сериализации для оптимизаций
- [ ] Добавить тесты
  - [x] Частично
- [ ] Рефакторинг и доп. оптимизации(мин.)
  - [x] Оптимизировано поле размера массива
  - [x] Уточнена работа метода members 
  - [ ] Много копипаста
- [x] Написать "how to use"
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
