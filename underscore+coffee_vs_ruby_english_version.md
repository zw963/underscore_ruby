# Coffee+underscore vs Ruby

Original base on http://www.css88.com/doc/underscore/.


The fancy `coffeescript` and `underscore` is written by same one author, so I think
both should be work well together, this article try to compare the programming
style about *underscore+coffeescript* with *Ruby* 

## Test Environment

### CoffeeScript + Underscore
1. create `underscore_coffee.html`, with following content:
```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="http://coffeescript.org/extras/coffee-script.js"></script>
    <script src="http://underscorejs.org/underscore-min.js"></script>
    <title>Underscore with coffee</title>
  </head>
  <body>
    <script type="text/coffeescript" src="underscore_coffee.coffee">
    </script>
  </body>
</html>
```

2. create `underscore_coffee.coffee`, the same folder as previous html file.
```coffee
window.print = (x...)->
  console.log x...

# coffee insert here
```

3. open html in your's browser, see console log output for result. (this article use Firefox 40)

### Ruby
install Ruby with your's favorite package manager, then run `irb` in terminal.

# Iterator with a Array/Object ##

## _.each list, iterator

```coffee
### Coffee Code ###

_.each [1, 2, 3], print

# Equivalent

_.each [1, 2, 3], (element, index, array)-> print element, index, array

# => 1 0 Array [1,2,3]
#    2 1 Array [1,2,3]
#    3 2 Array [1,2,3]

_.each {one: 1, two: 2, three: 3}, print

# Equivalent

_.each {one: 1, two: 2, three: 3}, (value, key, object)->
  print value, key, object
  
# => 1 one Object {one: 1, two: 2, three: 3}
#    2 two Object {one: 1, two: 2, three: 3}
#    3 three Object {one: 1, two: 2, three: 3}
```

```ruby
### Ruby code ###
[1, 2, 3].each_with_index {|e, i| print e, i, ary, "\n" }

# =>  10[1, 2, 3]
#     21[1, 2, 3]
#     32[1, 2, 3]

{one: 1, two: 2, three: 3}.each_pair {|key, value| print value, key, hash, "\n" }

# => 1one{:one=>1, :two=>2, :three=>3}
#    2two{:one=>1, :two=>2, :three=>3}
#    3three{:one=>1, :two=>2, :three=>3}
```

**Notice**
the arguments order is reverse between js function arguments and ruby block arguments.
What cause this is ruby use parallel assignment semantic, [:one, 1] corresponding to [key, value].

## _.map list, iterator

```coffee
### Coffee Code ###
print _.map [1.0, 2.3, 3], (element)-> Math.cos(element)
# => Array [ 0.5403023058681398, -0.6662760212798241, -0.9899924966004454 ]
# Equivalent usage
print _.map [1.0, 2.3, 3], Math.cos

print _.map ['XXX', 'YYY', 'XXXX', 'XXXXX'], (e)-> e.length # => [3, 3, 4, 5]
# Equivalent usage
print _.map ['XXX', 'YYY', 'XXXX', 'XXXXX'], 'length'
```

```ruby
### Ruby code ###
ary.map {|x| Math.cos(x) } # => [0.5403023058681398, -0.6662760212798241, -0.9899924966004454]
# No Equivalent usage

['XXX', 'YYY', 'XXXX', 'XXXXX'].map {|e| e.length } # => [3, 3, 4, 5]
# Equivalent usage
['XXX', 'YYY', 'XXXX', 'XXXXX'].map(&:length)
```

## pluck

```coffee
### Coffee Code ###

ary = [{name: 'billy', age: 30}, {name: 'zw963', age: 30}, {name: 'wei.zheng', age: 30}]
print _.pluck ary, 'name'

# => Array ["moe", "larry", "curly"]
```
      
```ruby
### Ruby code ###

ary = [{name: 'billy', age: 30}, {name: 'zw963', age: 30}, {name: 'wei.zheng', age: 30}]
ary.map {|e| e[:name] }

# Equivalent

ary.map {|e| e.[](:name) }

# => ["moe", "larry", "curly"]
```

## reduce/inject and reduceRight
_.reduce(list, iterator, memo) or inject(list, iterator, momo)

```coffee
### Coffee Code ###

ary = ['1', '2', '3']

print _.reduce ary, (memo, num)->
  memo.concat num
, ''

# => 123

print _.reduceRight ary, (memo, num)->
  memo.concat num
, ''

# => 321

```

```ruby
### Ruby code ###

ary = ['1', '2', '3']
ary.reduce('') {|memo, num| memo.concat num }

# => '123'

ary.reverse_each.reduce('') {|memo, num| memo.concat num }

# => '321'
```

## _.find(list, predicate)
Find the first element match predicate.

```coffee
### Coffee code ###

ary = [1, 2, 3, 4, 5, 6]
print _.find ary, (e)-> e % 2 == 0

# => 2
```

```ruby
### Ruby code ###

[1, 2, 3, 4, 5, 6].find {|e| e % 2 == 0 }

# => 2
```

## _.filter/select(list, predicate) _.reject(list, predicate)
```coffee
### Coffee code ###

ary = [1, 2, 3, 4, 5, 6]

print _.filter ary, (e)-> e % 2 == 0

# => Array [2, 4, 6]

print _.reject ary, (e) -> e % 2 == 0

# => Array [1, 3, 5]
```

```ruby
### Ruby code ###

[1, 2, 3, 4, 5, 6].select {|e| e % 2 == 0 } # => [2, 4, 6], alias find_all
[1, 2, 3, 4, 5, 6].reject {|e| e % 2 == 0 } # => [1, 3, 5]
```

## _.every(list, [predicate])
When predicate is omit, predicate all element is non-nil, else use predicate.

```coffee
### Coffee code ###

print _.every [true, 1, null] # => false
print _.every [true, 1, 'null'] # => true
print _.every [0, false, "", null, undefined, NaN], (e)-> !e # => true
```

```ruby
### Ruby code ###

["", 0].all? # => true
[nil, false].all? {|e| !e } # => true
```

## _.some(list, [predicate]) _.every(list, [predicate])
some: When predicate is omit, predicate at least one element is non-nil, else use predicate.
every: predicate all element is non-nil.
```coffee
### Coffee code ###

print _.some [true, 1, null] # => true
print _.every [true, 1, 'null'] # => true
print _.every [0, false, "", null, undefined, NaN], (e)-> !e # => true
```

```ruby
### Ruby code ###

["", 0].all? # => true
[nil, false].all? {|e| !e } # => true
```

## _.include/contains(list, value) 
```coffee
### Coffee code ###

print _.include [1, 2, 3],  3 # => true
```

```ruby
### Ruby code ###

[1, 2, 3].include? 3 # => true
```

## _.max(list, [iterator], [context]) _.min(list, [iterator], [context]) _.uniq(list, [iterator], [context]) 
```coffee
### Coffee code ###

print _.max [1, 2, 3, 4, 5, 6] # => 6
print _.min [1, 2, 3, 4, 5, 6] # => 1
print _.max [1, 2, 3, 4, 5, 6], (num)-> Math.sin(num) # => 2
print _.max [1, 2, 3, 4, 5, 6], Math.sin # => 2
print _.uniq [1, 1, 2, 3, 3] # => [1, 2, 3]
print _.uniq [1, -1, 2, -2, 3], Math.abs # => [1, 2, 3]
```

```ruby
### Ruby code ###

[1, 2, 3, 4, 5, 6].max # => 6
[1, 2, 3, 4, 5, 6].min # => 1
[1, 2, 3, 4, 5, 6].max {|e| Math.sin(e) } # => 4
[1, 2, 3, 4, -5, -6].max(&:abs) # => 6
[1, 1, 2, 3, 3].uniq # => [1, 2, 3]
[1, -1, 2, -2, 3].uniq {|x| x.abs } # => [1, 2, 3]
```

## _.sortBy(list, iterator)
Use a iterator as sort strategy, return sorted list.
```coffee
### Coffee code ###

print _.sortBy [1, 2, 3, 4, 5, 6], Math.sin # => [5, 4, 6, 3, 1, 2]
```

```ruby
### Ruby code ###
[1, 2, 3, 4, 5, 6].sort_by {|e| Match.sin(e) }
```

## _.groupBy/indexBy(list, predicate) countBy(list, predicate)
use a iterator as group strategy, return a grouped object, key is return value, value is grouped element list.
indexBy: key is return value, value is grouped element list last element.
```coffee
### Coffee code ###

print _.groupBy(['XXX', 'YYY', 'XXXX', 'XXXXX'], 'length'); # => { 3:["XXX", "YYY"], 4:["XXXX"], 5:["XXXXX"] }
print _.indexBy(['XXX', 'YYY', 'XXXX', 'XXXXX']), 'length') # => { 3:"YYY", 4:"XXXX", 5:"XXXXX" }
print _.countBy(['XXX', 'YYY', 'XXXX', 'XXXXX']), 'length') # => { 3:2, 4:1, 5:1 }

```

```ruby
### Ruby code ###
['XXX', 'YYY', 'XXXX', 'XXXXX'].group_by(&:length) # => {3=>["XXX", "YYY"], 4=>["XXXX"], 5=>["XXXXX"]}
['XXX', 'YYY', 'XXXX', 'XXXXX'].group_by(&:length).map {|k, v| [k,v.last] }.to_h # => {3=>"YYY", 4=>"XXXX", 5=>"XXXXX"}
['XXX', 'YYY', 'XXXX', 'XXXXX'].group_by(&:length).map {|k, v| [k,v.length] }.to_h # => {3=>2, 4=>1, 5=>1}
```

## _.partition(list, predicate)
paritition a list to two part.
```coffee
### Coffee code ###
print _.partition [0, 1, 2, 3, 4, 5], (num)-> num % 2 # => [[1, 3, 5], [0, 2, 4]]
```

```ruby
### Ruby code ###
[0, 1, 2, 3, 4, 5].partition {|e| e % 2 != 0 } # => [[1, 3, 5], [0, 2, 4]]
# Equivalent usage
[0, 1, 2, 3, 4, 5].partition(&:odd?)
```
       
## _.shuffle(list) _.sample(list, [n])
```coffee
### Coffee code ###
print _.shuffle [1, 2, 3, 4, 5, 6] # => [2, 4, 6, 5, 1, 3]
print _.sample [1, 2, 3, 4, 5, 6] # => 4
print _.sample [1, 2, 3, 4, 5, 6] # => 1
print _.sample [1, 2, 3, 4], 2 # => [3, 5]
```

```ruby
### Ruby code ###
[1, 2, 3, 4, 5, 6].shuffle # => [2, 5, 1, 3, 6, 4]
[1, 2, 3, 4, 5, 6].sample # => 1
[1, 2, 3, 4, 5, 6].sample(2) # => [4, 2]
```

## _.size(list)
```coffee
### Coffee code ###
print _.size [1, 2, 3, 4, 5, 6] # => 6
print _.size {a:100, b:200} # => 2
```

```ruby
### Ruby code ###
[1, 2, 3, 4, 5, 6].size # => 6
{a:100, b:200}.size # => 2
```

## _.where/findWhere(list, properties)
```coffee
### Coffee code ###
print _.where [{a:100, b:200}, {c:300, d:400}, {e:500, a:100}], {a: 100} # => [{a:100, b:200}, {e:500, a:100}]
# findWhere get the first element.
print _.findWhere [{a:100, b:200}, {c:300, d:400}, {e:500, a: 100}], {a: 100} # => [{a:100, b:200}]
```

```ruby
### Ruby code ###
No implement yet.
```

## _.toArray(list)
```coffee
### Coffee code ###
print _.toArray(arguments)
```

```ruby
### Ruby code ###
(1..10).to_a
```

# Iterator with a Array only (Object is not supported)

## _.first(list, [n]) _.last(list, [n])
```coffee
### Coffee code ###
print _.first [5, 4, 3, 2, 1], 2 # => [5, 4]
print _.last [5, 4, 3, 2, 1], 2 # => [2, 1]
```

```ruby
### Ruby code ###
[5, 4, 3, 2, 1].first(2)
[5, 4, 3, 2, 1].last(2)
```

## _.initial(list, [n])
```coffee
### Coffee code ###
print _.initial [5, 4, 3, 2, 1], 2 # => [5, 4, 3]
```

```ruby
### Ruby code ###
[5, 4, 3, 2, 1][0...-2] # => [5, 4, 3]
```

## _.rest(list, [n])
```coffee
### Coffee code ###
print _.rest [5, 4, 3, 2, 1], 2 # => [3, 2, 1]
```

```ruby
### Ruby code ###
[5, 4, 3, 2, 1].drop(2) # => [3, 2, 1]
[5, 4, 3, 2, 1][2..-1] # => [3, 2, 1]
```

## _.compact(list)
```coffee
### Coffee code ###
print _.compact [0, 1, false, 2, '', 3];  # => [1, 2, 3]
```

```ruby
### Ruby code ###
[0, false, '', nil].compact  # => [0, false, ''] # only remove nil

## following is same behavior with _.compact.
require 'active_support/all'
[0, 1, false, 2, '', 3].reject {|x| x.blank? or x == 0 } # => [1, 2, 3]
```

## _.flatten(list, [shallow])
```coffee
### Coffee code ###
print _.flatten [1, [2], [3, [4, 5], 6]] # => [1, 2, 3, 4, 5, 6]
print _.flatten [1, [2], [3, [4, 5], 6]], 1 # => [1, 2, 3, [4, 5], 6]
```

```ruby
### Ruby code ###
[1, [2], [3, [4, 5], 6]].flatten # => [1, 2, 3, 4, 5, 6]
[1, [2], [3, [4, 5], 6].flatten(1) # => [1, 2, 3, [4, 5], 6]
```

## _.without(list, [shallow])
```coffee
### Coffee code ###
print _.without [1, 2, 1, 0, 3, 1, 4], 0, 1  # => [2, 3, 4]
```

```ruby
### Ruby code ###
ary = [1, 2, 1, 0, 3, 1, 4]
ary.delete(0)
ary.delete(1)
ary # => [2, 3, 4]

# Or
ary.reject {|x| [0, 1].include? x } # => [2, 3, 4]
```

## _.union(*arrays) _.intersection(*arrays) _difference(array, *other_arrays)
```coffee
### Coffee code ###
print _.union [1, 2, 3], [101, 2, 1, 10] # => [1, 2, 3, 101, 10]
print _.intersection [1, 2, 3], [101, 2, 1, 10] # => [1, 2]
print _.difference [1, 2, 3, 4, 5], [5, 2, 10] # => [1, 3, 4]
```

```ruby
### Ruby code ###
[1, 2, 3] | [101, 2, 1, 10] # => [1, 2, 3, 101, 10]
[1, 2, 3] & [101, 2, 1, 10] # => [1, 2]
[1, 2, 3, 4, 5] - [5, 2, 10] # => [1, 3, 4]
```

## _.zip(*arrays) _.object(array1, array2)
```coffee
### Coffee code ###
print _.zip ['moe', 'larry', 'curly'], [30, 40, 50], [true, false, false]
# => Array [Array["moe", 30, true], Array["larry", 40, false], Array["curly", 50, false]]

print _.object ['moe', 'larry', 'curly'], [30, 40, 50]
# => {moe: 30, larry: 40, curly: 50}
```

```ruby
### Ruby code ###
['moe', 'larry', 'curly'].zip [30, 40, 50], [true, false, false]
# => [["moe", 30, true], ["larry", 40, false], ["curly", 50, false]]

['moe', 'larry', 'curly'].zip([30, 40, 50]).to_h
# => {moe: 30, larry: 40, curly: 50}
```

## _.indexOf(array, value) _.lastIndexOf(array, value)
```coffee
### Coffee code ###
print _.indexOf [1, 2, 3, 1, 2, 3], 2; # => 1, return -1 if not exist.
print _.lastIndexOf [1, 2, 3, 1, 2, 3], 2 # => 4, from right to left.
```

```ruby
### Ruby code ###
[1, 2, 3, 1, 2, 3].index(2)      # => 1, return nil if not exist.
[1, 2, 3, 1, 2, 3].rindex(2)     # => 4
```

## _.range([start], stop, [step])
```coffee
### Coffee code ###
print _.range 0, 30, 5 # => [0, 5, 10, 15, 20, 25]
```

```ruby
### Ruby code ###
(0..30).step(5)
```

## _.sortedIndex(sorted_list, value, [iterator], [context])
return the index which value should be insert into.
       
```coffee
### Coffee code ###
_.sortedIndex [10, 20, 30, 40, 50], 35 # => 3
```
       
```ruby
### Ruby code ###
class Array
  def sortedIndex(num)
    if block_given?
      array = map(&proc).sort
    else
      array = self
    end

    array.each_index do |index|
      return index if num.between?(array[index-1], array[index])
    end
    nil
  end
end

p [-60, 20, 30, 40, 50].sortedIndex(35)  # => 3
p [-60, 20, 30, 40, 50].sortedIndex(35) {|x| x.abs }# => 2
p [-60, 20, 30, 40, 50].sortedIndex(35) {|x| x * x }# => nil
```
       
## js 对象函数与 Ruby 哈希函数. ##

   1. _.keys(object) 
      
      ```js
      _.keys({one: 1, two: 2}); # => ["one", "two"]
      ```
      
      ```ruby
      Ruby:
      {one: 1, two: 2}.keys     # => [:one, :two]
      ```
      
   2. _.values(object) 
      
      ```js
      _.values({one: 1, two: 2});  # => [1, 2]
      ```
      
      ```ruby
      Ruby:
      {one: 1, two: 2}.values
      ```
      
   3. _.pairs(object)
      
      ```js
      _.pairs({one: 1, two: 2}); # => [["one", 1], ["two", 2]]
      ```
      
      ```ruby
      Ruby:
      {one: 1, two: 2}.to_a
      ```
      
   4. _.invert(object), 翻转
      
      ```js
      _.invert({Moe: "Moses", Larry: "Louis"}); # => {Moses: "Moe", Louis: "Larry"}
      ```
      
      ```ruby
      Ruby:
      {Moe: "Moses", Larry: "Louis"}  # => {"Moses" => :Moe, "Louis" => :Larry}
      ```
   5. _.functions(object) 或别名 _.methods(object), 返回某个对象之上可用的所有方法.
      
      ```js
      _.functions(_); 
      # =>
      # ["after", "all", "any", "bind", "bindAll", "chain", "clone", "collect", "compact", "compose",
      # "constant", "contains", "countBy", "debounce", "defaults", "defer", "delay", "detect", 
      # "difference", "drop", "each", "escape", "every", "extend", "filter", "find", "findWhere", 
      # "first", "flatten", "foldl", "foldr", "forEach", "functions", "groupBy", "has", "head", 
      # "identity", "include", "indexBy", "indexOf", "initial", "inject", "intersection", "invert", 
      # "invoke", "isArguments", "isArray", "isBoolean", "isDate", "isElement", "isEmpty", "isEqual", 
      # "isFinite", "isFunction", "isNaN", "isNull", "isNumber", "isObject", "isRegExp", "isString", 
      # "isUndefined", "keys", "last", "lastIndexOf", "map", "matches", "max", "memoize", "methods", 
      # "min", "mixin", "noConflict", "now", "object", "omit", "once", "pairs", "partial", "partition", 
      # "pick", "pluck", "property", "random", "range", "reduce", "reduceRight", "reject", "rest", 
      # "result", "sample", "select", "shuffle", "size", "some", "sortBy", "sortedIndex", "tail", 
      # "take", "tap", "template", "throttle", "times", "toArray", "unescape", "union", "uniq", 
      # "unique", "uniqueId", "values", "where", "without", "wrap", "zip"]
      ```
      
      ```ruby
      Ruby:
      object.methods
      ```

   6. _.extend(destination, *sources),  合并 sources 到 destination, 并返回修改后的 destination.
      
      ```js
      _.extend({name: 'moe'}, {name: 'larry', age: 30});  # => {name: 'larry', age: 30}
      ```
      
      ```ruby
      Ruby:
      {name: 'moe'}.merge! name: 'larry', age: 30
      ```

   9. _.defaults(object, *defaults), 合并不存在的 defaults 到 object, 返回修改后的 object.
      
      ```
      _.default({name: 'moe'}, {name: 'larry', age: 30});  # => {name: 'moe', age: 30}
      ```
      
      Ruby 版, 无等价方法, 可以自己写一个.
      ```ruby
      Ruby:
      class Hash
        def defaults(default)
          stripped_default = default.reject {|k, v| include? k }
          merge!(stripped_default)
        end
      end
      ```
      
   7. _.pick(object, *keys)
      
      ```js
      _.pick({name: 'moe', age: 50, userid: 'moe1'}, 'name', 'age') # => {name:"moe", age:50}
      ```
      
      ```ruby
      Ruby:
      {name: 'moe', age: 50, userid: 'moe1'}.assoc(:name), # => 仅支持一个参数.
      {name: 'moe', age: 50, userid: 'moe1'}.select {|k,v| k == :name or k == :age }
      ```

   8. _.omit(object, *keys)

      ```js
      _.omit({name: 'moe', age: 50, userid: 'moe1'}, 'userid') # => {name:"moe", age:50}
      ```
      
      ```ruby
      Ruby:
      {name: 'moe', age: 50, userid: 'moe1'}.reject {|k,v| k == :userid }
      ```
   10. _.clone(object), 创建对象的浅拷贝.
       
       ```js
       _.clone({name: 'moe'});
       ```
       
       ```ruby
       Ruby:
       {name: 'moe'}.clone
       ```
       
## 与函数有关的函数 ##
   1. Ruby 中的 call 和 js 中的 call.
   
   ```js
    var func = function (greeting) {
          return greeting + ': ' + this.name
     };

   func.call({name: 'moe'}, 'hi')       # => "hi: moe"
   ```

   ```ruby
   # 定义一个方法
       def func(greeting)
         greeting + ': ' + name
       end
       
   # 返回这个方法的方法对象. (和 js 不同的是: 这是一个 binding 到 `当前 self' 上的方法对象.)
   meth_object = method(:func) # => Object#func(greeting)
   
   # 模拟一个包含 name 属性的对象.
   o = Object.new;
   def o.name; 'moe' end
   
   # 将方法对象绑定新的对象 o.
   new_method_object = meth_object.bind(o)
   
   # 调用 call, 方法, 并传入参数.
   new_method_object.call('hi')   # => 'hi: moe'
   ```

   2. _.bind(function, object, *arguments)
      
      bind 和 call 唯一的区别是: bind 方法名作为第一个参数传入, 变相的实现了 Ruby 之中的 bind 方法.
      
      ```js
       var func = function (greeting) {
             return greeting + ': ' + this.name
        };

      new_func = _.bind(func, {name: 'moe'}, 'hi')
      new_func(); # => "hi: moe"
      ```
      
## 总结 ##
   1. underscore 的第一个参数就是 Ruby 中的 receiver(self), 并在 self 之上调用同名方法.
      js 之中的 function (x) { ... } 换做 Ruby 之中的 Block, {|x| ... }, 省略 return 就可以了.
   2. Js 和 Ruby 的 call, 唯一的差别是: 
      - Js 第一个参数是 this, 其余的参数传递给方法作为参数.
      - Ruby 单独通过 bind 绑定 self, call 仅接受传递给方法的参数.
   3. 如果用 Coffee 写 Js, 那就完美了.
      
