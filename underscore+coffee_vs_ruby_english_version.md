# Coffee+underscore vs Ruby

created by zw963

Original base on http://www.css88.com/doc/underscore/, current support version is 1.8.3

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

# coffee code input here
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
### Ruby Code ###

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

## _.map(list), iterator _.mapObject(object)

```coffee
### Coffee Code ###

print _.map [1.0, 2.3, 3], (element)-> Math.cos(element)
# => Array [ 0.5403023058681398, -0.6662760212798241, -0.9899924966004454 ]
# Equivalent usage
print _.map [1.0, 2.3, 3], Math.cos

print _.map ['XXX', 'YYY', 'XXXX', 'XXXXX'], (e)-> e.length # => [3, 3, 4, 5]
# Equivalent usage
print _.map ['XXX', 'YYY', 'XXXX', 'XXXXX'], 'length'

print _.mapObject {start: 5, end: 12}, (val, key)-> val + 5 # => {start: 10, end: 17}
```

```ruby
### Ruby Code ###

ary.map {|x| Math.cos(x) } # => [0.5403023058681398, -0.6662760212798241, -0.9899924966004454]
# No Equivalent usage

['XXX', 'YYY', 'XXXX', 'XXXXX'].map {|e| e.length } # => [3, 3, 4, 5]
# Equivalent usage
['XXX', 'YYY', 'XXXX', 'XXXXX'].map(&:length)

{start: 5, end: 12}.map {|k, v| [k, v+5] }.to_h         # => {start: 10, end: 17}
```

## pluck

```coffee
### Coffee Code ###

ary = [{name: 'billy', age: 30}, {name: 'zw963', age: 30}, {name: 'wei.zheng', age: 30}]
print _.pluck ary, 'name'

# => Array ["moe", "larry", "curly"]
```
      
```ruby
### Ruby Code ###

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
, ''_.findLastIndex(array, predicate, [context])

# => 123

print _.reduceRight ary, (memo, num)->
  memo.concat num
, ''

# => 321

```

```ruby
### Ruby Code ###

ary = ['1', '2', '3']
ary.reduce('') {|memo, num| memo.concat num }

# => '123'

ary.reverse_each.reduce('') {|memo, num| memo.concat num }

# => '321'
```

## _.filter/select(list, predicate) _.reject(list, predicate)
```coffee
### Coffee Code ###

ary = [1, 2, 3, 4, 5, 6]

print _.filter ary, (e)-> e % 2 == 0

# => Array [2, 4, 6]

print _.reject ary, (e) -> e % 2 == 0

# => Array [1, 3, 5]
```

```ruby
### Ruby Code ###

[1, 2, 3, 4, 5, 6].select {|e| e % 2 == 0 } # => [2, 4, 6], alias find_all
[1, 2, 3, 4, 5, 6].reject {|e| e % 2 == 0 } # => [1, 3, 5]
```

## _.every(list, [predicate])
When predicate is omit, predicate all element is non-nil, else use predicate.

```coffee
### Coffee Code ###

print _.every [true, 1, null] # => false
print _.every [true, 1, 'null'] # => true
print _.every [0, false, "", null, undefined, NaN], (e)-> !e # => true
```

```ruby
### Ruby Code ###

["", 0].all? # => true
[nil, false].all? {|e| !e } # => true
```

## _.some(list, [predicate]) _.every(list, [predicate])
some: When predicate is omit, predicate at least one element is non-nil, else use predicate.
every: predicate all element is non-nil.
```coffee
### Coffee Code ###

print _.some [true, 1, null] # => true
print _.every [true, 1, 'null'] # => true
print _.every [0, false, "", null, undefined, NaN], (e)-> !e # => true
```

```ruby
### Ruby Code ###

["", 0].all? # => true
[nil, false].all? {|e| !e } # => true
```

## _.include/contains(list, value) 
```coffee
### Coffee Code ###

print _.include [1, 2, 3],  3 # => true
```

```ruby
### Ruby Code ###

[1, 2, 3].include? 3 # => true
```

## _.invoke(list, methodName, *arguments)
```coffee
### Coffee Code ###

_.invoke [[5, 1, 7], [3, 2, 1]], 'sort'  # => [[1, 5, 7], [1, 2, 3]]
```

```ruby
### Ruby Code ###

[[5, 1, 7], [3, 2, 1]].map {|e| e.sort }  # => [[1, 5, 7], [1, 2, 3]]
```


## _.max(list, [iterator], [context]) _.min(list, [iterator], [context]) _.uniq(list, [iterator], [context]) 
```coffee
### Coffee Code ###

print _.max [1, 2, 3, 4, 5, 6] # => 6
print _.min [1, 2, 3, 4, 5, 6] # => 1
print _.max [1, 2, 3, 4, 5, 6], (num)-> Math.sin(num) # => 2
print _.max [1, 2, 3, 4, 5, 6], Math.sin # => 2
print _.uniq [1, 1, 2, 3, 3] # => [1, 2, 3]
print _.uniq [1, -1, 2, -2, 3], Math.abs # => [1, 2, 3]
```

```ruby
### Ruby Code ###

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
### Coffee Code ###

print _.sortBy [1, 2, 3, 4, 5, 6], Math.sin # => [5, 4, 6, 3, 1, 2]
```

```ruby
### Ruby Code ###

[1, 2, 3, 4, 5, 6].sort_by {|e| Match.sin(e) }
```

## _.groupBy/indexBy(list, predicate) countBy(list, predicate)
use a iterator as group strategy, return a grouped object, key is return value, value is grouped element list.
indexBy: key is return value, value is grouped element list last element.
```coffee
### Coffee Code ###

print _.groupBy(['XXX', 'YYY', 'XXXX', 'XXXXX'], 'length'); # => {3: ["XXX", "YYY"], 4: ["XXXX"], 5: ["XXXXX"]}
print _.indexBy(['XXX', 'YYY', 'XXXX', 'XXXXX']), 'length') # => {3: "YYY", 4: "XXXX", 5: "XXXXX"}
print _.countBy(['XXX', 'YYY', 'XXXX', 'XXXXX']), 'length') # => {3: 2, 4: 1, 5: 1}

```

```ruby
### Ruby Code ###

# NOTICE: When key is not a symbol, ruby hash use `hash rocket` representation.
['XXX', 'YYY', 'XXXX', 'XXXXX'].group_by(&:length)  # => {3 => ["XXX", "YYY"], 4 => ["XXXX"], 5 => ["XXXXX"]}
['XXX', 'YYY', 'XXXX', 'XXXXX'].group_by(&:length).map {|k, v| [k,v.last] }.to_h # => {3 => "YYY", 4 => "XXXX", 5=>"XXXXX"}
['XXX', 'YYY', 'XXXX', 'XXXXX'].group_by(&:length).map {|k, v| [k,v.length] }.to_h # => {3 => 2, 4 => 1, 5 => 1}
```

## _.partition(list, predicate)
paritition a list to two part.
```coffee
### Coffee Code ###

print _.partition [0, 1, 2, 3, 4, 5], (num)-> num % 2 # => [[1, 3, 5], [0, 2, 4]]
```

```ruby
### Ruby Code ###

[0, 1, 2, 3, 4, 5].partition {|e| e % 2 != 0 } # => [[1, 3, 5], [0, 2, 4]]
# Equivalent usage
[0, 1, 2, 3, 4, 5].partition(&:odd?)
```
       
## _.shuffle(list) _.sample(list, [n])
```coffee
### Coffee Code ###

print _.shuffle [1, 2, 3, 4, 5, 6] # => [2, 4, 6, 5, 1, 3]
print _.sample [1, 2, 3, 4, 5, 6] # => 4
print _.sample [1, 2, 3, 4, 5, 6] # => 1
print _.sample [1, 2, 3, 4], 2 # => [3, 5]
```

```ruby
### Ruby Code ###

[1, 2, 3, 4, 5, 6].shuffle # => [2, 5, 1, 3, 6, 4]
[1, 2, 3, 4, 5, 6].sample # => 1
[1, 2, 3, 4, 5, 6].sample(2) # => [4, 2]
```

## _.size(list)
```coffee
### Coffee Code ###

print _.size [1, 2, 3, 4, 5, 6] # => 6
print _.size {a:100, b:200} # => 2
```

```ruby
### Ruby Code ###

[1, 2, 3, 4, 5, 6].size # => 6
{a:100, b:200}.size # => 2
```

## _.toArray(list), useful for convert arguments.
```coffee
### Coffee Code ###

print _.toArray(arguments)
```

```ruby
### Ruby No implement. ###
```

# Iterator with a Array only (Object is not supported)

## _.first(list, [n]) _.last(list, [n])
```coffee
### Coffee Code ###

print _.first [5, 4, 3, 2, 1], 2 # => [5, 4]
print _.last [5, 4, 3, 2, 1], 2 # => [2, 1]
```

```ruby
### Ruby Code ###

[5, 4, 3, 2, 1].first(2)
[5, 4, 3, 2, 1].last(2)
```

## _.initial(list, [n])
```coffee
### Coffee Code ###

print _.initial [5, 4, 3, 2, 1], 2 # => [5, 4, 3]
```

```ruby
### Ruby Code ###

[5, 4, 3, 2, 1][0...-2] # => [5, 4, 3]
```

## _.drop(list, [n])
```coffee
### Coffee Code ###

print _.drop [5, 4, 3, 2, 1], 2 # => [3, 2, 1]
```

```ruby
### Ruby Code ###

[5, 4, 3, 2, 1].drop(2) # => [3, 2, 1]
[5, 4, 3, 2, 1][2..-1] # => [3, 2, 1]
```

## _.compact(list)
```coffee
### Coffee Code ###
print _.compact [0, 1, false, 2, '', 3];  # => [1, 2, 3]
```

```ruby
### Ruby Code ###

[0, false, '', nil].compact  # => [0, false, ''] # only remove nil

## following is same behavior with _.compact.
require 'active_support/all'
[0, 1, false, 2, '', 3].reject {|x| x.blank? or x == 0 } # => [1, 2, 3]
```

## _.flatten(list, [shallow])
```coffee
### Coffee Code ###

print _.flatten [1, [2], [3, [4, 5], 6]] # => [1, 2, 3, 4, 5, 6]
print _.flatten [1, [2], [3, [4, 5], 6]], 1 # => [1, 2, 3, [4, 5], 6]
```

```ruby
### Ruby Code ###

[1, [2], [3, [4, 5], 6]].flatten # => [1, 2, 3, 4, 5, 6]
[1, [2], [3, [4, 5], 6].flatten(1) # => [1, 2, 3, [4, 5], 6]
```

## _.without(list, [shallow])
```coffee
### Coffee Code ###

print _.without [1, 2, 1, 0, 3, 1, 4], 0, 1  # => [2, 3, 4]
```

```ruby
### Ruby Code ###

ary = [1, 2, 1, 0, 3, 1, 4]
ary.delete(0)
ary.delete(1)
ary # => [2, 3, 4]

# Or
ary.reject {|x| [0, 1].include? x } # => [2, 3, 4]
```

## _.union(*arrays) _.intersection(*arrays) _difference(array, *other_arrays)
```coffee
### Coffee Code ###

print _.union [1, 2, 3], [101, 2, 1, 10] # => [1, 2, 3, 101, 10]
print _.intersection [1, 2, 3], [101, 2, 1, 10] # => [1, 2]
print _.difference [1, 2, 3, 4, 5], [5, 2, 10] # => [1, 3, 4]
```

```ruby
### Ruby Code ###

[1, 2, 3] | [101, 2, 1, 10] # => [1, 2, 3, 101, 10]
[1, 2, 3] & [101, 2, 1, 10] # => [1, 2]
[1, 2, 3, 4, 5] - [5, 2, 10] # => [1, 3, 4]
```

## _.zip(*arrays) _.unzip(*arrays) _.object(array1, array2)
```coffee
### Coffee Code ###

print _.zip ['moe', 'larry', 'curly'], [30, 40, 50], [true, false, false]
# => Array [Array["moe", 30, true], Array["larry", 40, false], Array["curly", 50, false]]

print _.unzip [['moe', 'larry', 'curly'], [30, 40, 50], [true, false, false]]
# => [["moe", 30, true], ["larry", 40, false], ["curly", 50, false]]

print _.object ['moe', 'larry', 'curly'], [30, 40, 50]
# => {moe: 30, larry: 40, curly: 50}
```

```ruby
### Ruby Code ###

['moe', 'larry', 'curly'].zip [30, 40, 50], [true, false, false]
# => [["moe", 30, true], ["larry", 40, false], ["curly", 50, false]]

[['moe', 'larry', 'curly'], [30, 40, 50], [true, false, false]].transpose
# => [["moe", 30, true], ["larry", 40, false], ["curly", 50, false]]

['moe', 'larry', 'curly'].zip([30, 40, 50]).to_h
# => {moe: 30, larry: 40, curly: 50}
```

## _.find(list, predicate)
Find the first element match predicate.

```coffee
### Coffee Code ###

ary = [1, 2, 3, 4, 5, 6]
print _.find ary, (e)-> e % 2 == 0

# => 2
```

```ruby
### Ruby Code ###

[1, 2, 3, 4, 5, 6].find {|e| e % 2 == 0 }

# => 2
```

## _.indexOf/lastIndexOf(array, value) _.findIndex/findLastIndex(array, predicate, [context])
```coffee
### Coffee Code ###

# return element index
print _.indexOf [1, 2, 3, 1, 2, 3], 2;          # => 1, return -1 if not found.
print _.lastIndexOf [1, 2, 3, 1, 2, 3], 2       # => 4, from right to left.

# return predicate is true index
print _.findIndex([4, 6, 8, 12], isPrime)       # => -1, not found
print _.findIndex([4, 6, 7, 12], isPrime)       # => 2

var users = [{'id': 1, 'name': 'Bob', 'last': 'Brown'},
             {'id': 2, 'name': 'Ted', 'last': 'White'},
             {'id': 3, 'name': 'Frank', 'last': 'James'},
             {'id': 4, 'name': 'Ted', 'last': 'Jones'}]
_.findLastIndex(users, {
  name: 'Ted'
});
```

## _.where/findWhere(list, properties)
```coffee
### Coffee Code ###

print _.where [{a:100, b:200}, {c:300, d:400}, {e:500, a:100}], {a: 100} # => [{a:100, b:200}, {e:500, a:100}]
# findWhere get the first element.
print _.findWhere [{a:100, b:200}, {c:300, d:400}, {e:500, a: 100}], {a: 100} # => {a:100, b:200}
```

```ruby
### Ruby No implement ###

# rewrite Hash include? method. (default include? only check key)
class Hash
  def include?(other)
    self.merge(other) == self
  end
end

[{a:100, b:200}, {c:300, d:400}, {e:500, a:100}].select {|x| x.include?(a: 100) } # => [{a:100, b:200}, {e:500, a:100}]
[{a:100, b:200}, {c:300, d:400}, {e:500, a:100}].find {|x| x.include?(a: 100) }  # => {a:100, b:200}
```

```ruby
### Ruby Code ###

[1, 2, 3, 1, 2, 3].index(2)      # => 1, return nil if not exist.
[1, 2, 3, 1, 2, 3].rindex(2)     # => 4
```

## _.range([start], stop, [step])
```coffee
### Coffee Code ###

print _.range 0, 30, 5 # => [0, 5, 10, 15, 20, 25]
```

```ruby
### Ruby Code ###

(0..30).step(5)
```

## _.sortedIndex(sorted_list, value, [iterator], [context])
return the index which value should be insert into.
       
```coffee
### Coffee Code ###

    

_.sortedIndex [10, 20, 30, 40, 50], 35 # => 3
```
       
```ruby
### Ruby code ###

class Array
  def sortedIndex(num)
      each_index do |index|
        return index if num <= array[index]
      end
      nil
    end
  end
end

or more efficiently

class Array
  def sortedIndex(num)
    ele = bsearch {|e| num <= e }
    index(ele)
  end
end

[-60, 20, 30, 40, 50].sortedIndex(35)  # => 3
[-60, 20, 30, 40, 50].sortedIndex(35) {|x| x.abs }# => 2
[-60, 20, 30, 40, 50].sortedIndex(35) {|x| x * x }# => nil
```

# Iterator with a Object only (Array is not supported)
       
## _.keys(object) _allKeys(object) _.values(object) _.pairs(object)
      
```coffee
### Coffee Code ###

_.keys one: 1, two: 2           # => ["one", "two"]
_.values one: 1, two: 2         # => [1, 2]
_.pairs one: 1, two: 2          # => [["one", 1], ["two", 2]]
```
      
```ruby
### Ruby Code ###

{one: 1, two: 2}.keys           # => [:one, :two]
{one: 1, two: 2}.values         # => [1, 2]
{one: 1, two: 2}.to_a           # => [['one', 1], ['two', 2]]
```

## _.invert(object)
```coffee
### Coffee Code ###

_.invert Moe: "Moses", Larry: "Louis"           # => {Moses: "Moe", Louis: "Larry"}
```

```ruby
### Ruby Code ###

{Moe: "Moses", Larry: "Louis"}.invert           # => {"Moses" => :Moe, "Louis" => :Larry}
```

## _.functions/methods(object)
      
```coffee
### Coffee Code ###

_.functions _
# =>
  ["after", "all", "any", "bind", "bindAll", "chain", "clone", "collect", "compact", "compose",
  "constant", "contains", "countBy", "debounce", "defaults", "defer", "delay", "detect", 
  "difference", "drop", "each", "escape", "every", "extend", "filter", "find", "findWhere", 
  "first", "flatten", "foldl", "foldr", "forEach", "functions", "groupBy", "has", "head", 
  "identity", "include", "indexBy", "indexOf", "initial", "inject", "intersection", "invert", 
  "invoke", "isArguments", "isArray", "isBoolean", "isDate", "isElement", "isEmpty", "isEqual", 
  "isFinite", "isFunction", "isNaN", "isNull", "isNumber", "isObject", "isRegExp", "isString", 
  "isUndefined", "keys", "last", "lastIndexOf", "map", "matches", "max", "memoize", "methods", 
  "min", "mixin", "noConflict", "now", "object", "omit", "once", "pairs", "partial", "partition", 
  "pick", "pluck", "property", "random", "range", "reduce", "reduceRight", "reject", "rest", 
  "result", "sample", "select", "shuffle", "size", "some", "sortBy", "sortedIndex", "tail", 
  "take", "tap", "template", "throttle", "times", "toArray", "unescape", "union", "uniq", 
  "unique", "uniqueId", "values", "where", "without", "wrap", "zip"]
```
      
```ruby
### Ruby Code ###

a_object.methods # => [:meth1, meth2 ...]
```

## _.extend(destination, *sources) _.extendOwn(destination, *sources)
```coffee
### Coffee Code ###

a = {age: 30}
b = Object.create(a)
b.name = 'moe'
print b         # => {name: 'moe'}
print b.age     # => 30
# Here b is a object which exist own property `name` and prototype property `age`.

o = {}
_.extend o, b
print o         # => {name: 'moe', age: 30}

o = {}
# _.extendOwn is alias of Object.assign in ES6
_.extendOwn o, b
print o         # => {name: 'moe'}
```
      
```ruby
### Ruby Code ###

x = {name: 'moe'}
x.merge! name: 'larry', age: 30
print x # => {name: 'larry', age: 30}

o = Object.new
o.say_hello             # => NoMethodError: undefined method `say_hello`

module NewBehavior
  def say_hello
    'Hello!'
  end
end

o.extend NewBehavior
o.say_hello             # => Hello!
```

## 

## _.defaults(object, *defaults)
```coffee
### Coffee Code ###
x = {name: 'moe'}
_.default x, name: 'larry', age: 30  # => {name: 'moe', age: 30}
```

```ruby
### Ruby Code ###
class Hash
  def defaults(default)
    stripped_default = default.reject {|k, v| include? k }
    merge!(stripped_default)
  end
end
```
      
## _.pick(object, *keys) _.omit(object, *keys)

```coffee
### Coffee Code ###

_.pick {name: 'moe', age: 50, userid: 100}, 'name', 'age'    # => {name:"moe", age:50}
_.omit {name: 'moe', age: 50, userid: 100}, 'userid'         # => {name:"moe", age:50}
```

```ruby
### Ruby Code ###

require 'active_support/all'
{name: 'moe', age: 50, userid: 100}.slice :name, :age        # => {name: 'moe', age: 50}
{name: 'moe', age: 50, userid: 100}.except :userid           # => {name: 'moe', age: 50}
```

## _.tap(object, interceptor)
```coffee
### Coffee Code ###

x = _.chain([1,2,3,200])
  .filter (num)->
    num % 2 == 0                        # => return [2, 200]
  .tap alert                            # => alert([2, 200]), and return [2, 200] again.
  .map (num)->
    num * num                           # => return [4, 40000]
  .value()
print x
```

```ruby
### Ruby Code ###

[1, 2, 3, 200]
  .select {|x| x % 2 == 0 }
  .tap {|x| puts x }
  .map {|x| x * x }
```

## _.has(object, key)
```coffee
### Coffee Code ###

_.has {a: 1, b: 2, c: 3}, "b"           # => true
```

```ruby
### Ruby Code ###

{a: 1, b: 2, c: 3}.has_key? :b          # => true
```

## _.property(key) _.propertyOf(object)
```coffee
### Coffee Code ###

stooge = {name: 'moe'}
'moe' == _.property('name')(stooge);
=> true
```

## _.matcher(attrs)
```coffee
### Coffee Code ###

# return a predicate
ready = _.matcher selected: true, visible: true
# use this predicate as filter argument.
readyToGoList = _.filter list, ready
```

```ruby
### Ruby Code ###

ready = proc {|k, v| k[:selected] == true and k[:visible] == true }
readyToGoList = list.select(&:ready)
```

## _.clone(object)

```coffee
### Coffee Code ###

# shallow clone
_.clone({name: 'moe'});
```

```ruby
### Ruby Code ###

{name: 'moe'}.clone
```

## isEqual

```js
/// JS Code ///

var stooge = {name: 'moe', luckyNumbers: [13, 27, 34]};
var clone  = {name: 'moe', luckyNumbers: [13, 27, 34]};
console.log(stooge == clone);                           // false
console.log(_.isEqual(stooge, clone));                  // true
```

```ruby
### Ruby Code ###

stooge = {name: 'moe', luckyNumbers: [13, 27, 34]}
clone  = {name: 'moe', luckyNumbers: [13, 27, 34]}

# stooge and clone not same object.
p stooge.object_id  # => 3659860
p clone.object_id   # => 3659580

p stooge.equal? clone   # => false
p stooge == clone       # => true
```

## _.isMatch(object, properties)
```coffee
### Coffee Code ###

_.isMatch {name: 'moe', age: 32, userid: 100}, age: 32, name: 'moe'       # => true
```

```ruby
### Ruby Code ###

class Hash
  def include?(other)
    self.merge(other) == self
  end
end

{name: 'moe', age: 32, userid: 100}.include? age: 32, name: 'moe'    # => true
```

## _.isEmpty(object)
```coffee
### Coffee Code ###

print _.isEmpty([1, 2, 3]);             # => false
print _.isEmpty([])                     # => true
print _.isEmpty({})                     # => true
print _.isEmpty('')                     # => true
```

```ruby
### Ruby Code ###

[1, 2, 3].empty?        # => false
[].empty?               # => true
{}.empty?               # => true
''.empty?               # => true
```

## _.isElement(object) _.isArray(object) _.isObject(value) _.isString(object) _.isNumber(object) _.isBoolean(object)

```coffee
### Coffee Code ###

dom = $('body')[0]
# return true if object is a DOM element
print _.isElement dom           # => true

print _.isArray [1, 2, 3]       # => true
print _.isObject [1, 2, 3]      # => true, Array is object
print _.isObject {a: 100}       # => true
print _.isObject 'hello'        # => false, String is not Object.
print _.isString 'hello'        # => true
print _.isObject 100            # => false, number is not Object.
print _.isNumber 100            # => true
print _.isBoolean null          # => true 
```

```ruby
### Ruby Code ###

# dom Object is not exist

Array === [1, 2, 3]             # => true
Hash === {a: 100}               # => true
String === 'hello'              # => true
Numeric === 100                 # => true

# Ruby no boolean type, TrueClass, FalseClass instead.
NilClass === nil
```

## _.isArguments(object) _.isFunction(object) .isDate(object) _.isFinite(object) isRegExp(object) _.isError(object)
```coffee
### Coffee Code ###

print (-> _.isArguments(arguments))(1, 2, 3)            # => true
print _.isArguments [1,2,3]                             # => false
print _.isFunction alert                                # => true
print _.isDate(new Date())                              # => true
print _.isRegExp(/moe/)                                 # => true
print _.isError(new TypeError("Example"))               # => true
```

```ruby
### Ruby Code ###

# Ruby no arguments type.

meth = method(:puts)
Method === meth                                 # => true
Date === Date.new                               # => true
Regexp === /moe/                                # => true
Exception === TypeError.new('Example')          # => true
```

## _.isFinite(object) _.isNaN(object) _.isNull(object) _.isUndefined(value)
```coffee
### Coffee Code ###

print _.isFinite(101)                           # => true
print _.isFinite(Infinity)                      # => false

print _.isNaN(NaN)                              # => true
print _.isNaN(undefined)                        # => false

# js defaullt isNaN function, undefined will return true
print isNaN(undefined)                          # => true

print _.isNull(null)                            # => true
print _.isNull(undefined)                       # => false

print _.isUndefined(window.missingVariable)     # => true
```

```ruby
### Ruby Code ###

101.0.finite?                                   # => true
(1.0/0.0).finite?                               # => false
(1.0/0.0).infinite?                             # => true
101.0.nan?                                      # => false
(0.0/0.0).nan?                                  # => true
# Ruby nil is JS null.
nil.nil?                                        # => true

defined? asdfasdf                               # => nil
```

# Ruby call vs js call, and _.bind(function, object, *arguments)

## _.bind(function, object, *arguments)

```js
/// JS Code ///

// create a local anonymous function
 var sayHi = function (greeting) {
       return greeting + '! ' + this.name
  };

# normally invoke on a object not work.
{name: 'moe'}.sayHi('Hi');                      // sayHi is not a function

# with call, it work.
sayHi.call({name: 'moe'}, 'Hi');                // => "Hi! moe"

# with _.bind, we can create a new local binded function.
new_sayHi = _.bind(sayHi, {name: 'moe'}, 'Hi');
# and defer invoke it.
new_sayHi();                                    // => "Hi! moe"
```

```coffee
### Coffee Code ###

sayHi = (greeting)->
  "#{greeting! @name}"

print {name: 'moe'}.sayHi 'Hi'                  # => sayHi is not a function

print sayHi.call name: 'moe', 'hi'              # => "Hi! moe"

new_sayHi = _.bind sayHi, {name: 'moe'}, 'hi'
print new_sayHi()                               # => "hi: moe"
```

```ruby
### Ruby Code ###

require 'ostruct'
o = OpenStruct.new(name: 'moe')  # => #<OpenStruct name="moe">

def say_hi(greeting)
  "#{greeting! name}"
end

# normally invoke work, because top space belong to Object.
o.say_hi('Hi')

# cat Bound Method Object, and then call with arguments.
o.method(:say_hi).call('hi')                    # => "Hi! moe"

# get Unbound Method Object, and then bind a object onto, finally call with argument.
instance_method(:func).bind(o).call('hi')       # => "hi: moe"
```

## _.bindAll(object, *methodNames)
```coffee
### Coffee Code ###

# default, `this` is buttonView object.
buttonView =
  label: 'underscore',
  onClick: -> console.log('clicked: ' + this.label)
  onHover: -> console.log('hovering: ' + this.label)

# it worked as we want
buttonView.onClick()    # => 'clicked: underscore'

# But use with JQuery. this is binded to the button DOM.
$('#underscore_button').on('click', buttonView.onClick)
$('#underscore_button').trigger('click')        # => 'clicked: undefined'

# bind this to original this.
_.bindAll(buttonView, 'onClick', 'onHover')
$('#underscore_button').on('click', buttonView.onClick)
$('#underscore_button').trigger('click')        # => 'clicked: underscore'
```

# Chain

## _.chain(obj), alias _(obj)
```coffee
### Coffee Code ###
lyrics = [
  {line: 1, words: "I'm a lumberjack and I'm okay"},
  {line: 2, words: "I sleep all night and I work all day"},
  {line: 3, words: "He's a lumberjack and he's okay"},
  {line: 4, words: "He sleeps all night and he works all day"}
]

x =  _.chain(lyrics)
  .map (line)->
    line.words.split(' ')
  .flatten()
  .reduce (counts, word)->
    counts[word] = (counts[word] || 0) + 1
    counts
  , {}
  .value()

print x
```

```ruby
### Ruby Code ###

lyrics = [
  {line: 1, words: "I'm a lumberjack and I'm okay"},
  {line: 2, words: "I sleep all night and I work all day"},
  {line: 3, words: "He's a lumberjack and he's okay"},
  {line: 4, words: "He sleeps all night and he works all day"}
]

# use reduce/inject
lyrics.map {|x| x[:words].split(' ') }
  .flatten
  .reduce(Hash.new(0)) {|counts, word| counts[word] += 1; counts }
  
# the better way is use each_with_object for this.
lyrics.map {|x| x[:words].split(' ') }
  .flatten
  .each_with_object(Hash.new(0)) {|word, counts| counts[word] += 1 }
```

## _.times(n, iteratee, [context])
```coffee
### Coffee Code ###

_.chain(3).times (idx)-> print idx      # => 0 1 2
```

```ruby
### Ruby Code ###

3.times {|idx| print idx }              # => 0 1 2
```

# Asynchronization

## _.defer(function, *arguments)
```coffee
### Coffee Code ###

# js is single threaded, run this code in the next run loop
_.defer -> alert after # or _.defer alert, 'after'

# this code is execute in current loop.
# when it finished, will start next run loop.
alert 'before'

# result: alert 'before' first, and then alert 'after'.
```

## _.before(count, function)
```coffee
### Coffee Code ###

monthlyMeeting = _.before(3, askForRaise)
monthlyMeeting();
monthlyMeeting();

# the result of any subsequent calls is the same as the second call
# following will return second call result directly.
monthlyMeeting();
```

## _.after(count, function)
```coffee
### Coffee Code ###

# When FUNCTION is invoked COUNT times, it become effective.

renderNotes = _.after(notes.length, render);
_.each notes, (note)->
  # only the last invoked `renderNotes` is effective.
  # this will ensure renderNotes will be invoke if all note is async finished.
  note.asyncSave({success: renderNotes});
```

# Others

## _.random(min, max)
```coffee
### Coffee Code ###

_.random 0, 100                # => 42
```

```ruby
### Ruby Code ###

rand(0..100)
```

## _.delay(function, wait, *arguments)
```coffee
### Coffee Code ###

# a binded function, can be defer invoke.
log = _.bind console.log, console
_.delay log, 1000, 'logged later'     # => 'logged later'
```

```ruby
### Ruby Code ###

log = method(:puts)
sleep 1
log.call('logged later')
```

## _.once(function)
```coffee
### Coffee Code ###

initialize = _.once createApplication
initialize()
initialize()
# Application is only create once.
```

```ruby
### Ruby Code ###

# approximately equivalence, only be invoke once.
BEGIN { createApplication }
```

## _.throttle(function, wait, [options])
```coffee
### Coffee Code ###

# updatePosition at most be invoke 1 time within 100ms.
throttled = _.throttle(updatePosition, 100);
$(window).scroll(throttled);
```

## _.debounce(function, wait, [immediate])
```coffee
### Coffee Code ###

# calculateLayout will be invoke only idle time greater than 300ms.
lazyLayout = _.debounce(calculateLayout, 300);
$(window).resize(lazyLayout);
```

## _.negate(predicate), return a predicate function negative version.
```coffee
### Coffee Code ###
isFalsy = _.negate(Boolean);
_.find([-2, -1, 0, 1, 2, ''], isFalsy); => 0
```

## _.wrap(function, wrapper)
```coffee
### Coffee Code ###

hello = (name)-> "hello: #{name}"
hello = _.wrap hello, (func)-> "before, #{func("moe")}, after"
hello() # => 'before, hello: moe, after'
```

## _.compose(*functions)
```coffee
### Coffee Code ###

# compose f(), g(), h() as h(g(f()))
greet = (name)-> "hi: #{name}"
exclaim  = (statement)-> statement.toUpperCase() + "!"
welcome = _.compose(greet, exclaim)
welcome('moe')          => 'hi: MOE!'
```

## _.partial(function, *arguments)
```coffee
### Coffee Code ###

addition = (a, b)-> a + b
add5 = _.partial(addition, 5);
print add5(15) # => 20
```

```ruby
### Ruby Code ###

addition = proc {|a, b| a + b }
add5 = addition.curry[5]
add5.call(15)
```

## _.identity(value) _.constant(value) 
```coffee
### Coffee Code ###

stooge = {name: 'moe'}
stooge == _.identity(stooge)    # => true
print _.groupBy [2, 3, 3, 1, 2, 3, 3, 1, 1, 2], _.identity
# => {1: [1, 1, 1], 2: [2, 2, 2], 3: [3, 3, 3, 3]}

# _.constant(stooge) return a function instead of value, i don't know where to use it.
stooge == _.constant(stooge)()  # => true
```

```ruby
### Ruby Code ###

stooge = {name: 'moe'}
stooge == stooge.itself         # => true
[2, 3, 3, 1, 2, 3, 3, 1, 1, 2].group_by(&:itself)
# => {1 => [1, 1, 1], 2 => [2, 2, 2], 3 => [3, 3, 3, 3]}

# _.constant() is not implement in ruby
```

## _.escape(string) _.unescape(string)
```coffee
### Coffee Code ###

_.escape 'Curly, Larry & Moe'           # => "Curly, Larry &amp; Moe"
_.escape 'Curly, Larry &amp; Moe'       # => 'Curly, Larry & Moe'
```

```ruby
### Ruby Code ###

CGI.escapeHTML('Curly, Larry & Moe')            # => "Curly, Larry &amp; Moe"
CGI.unescapeHTML('Curly, Larry &amp; Moe')      # => 'Curly, Larry & Moe'
```

## _.now(), current time represent as integer.
```coffee
### Coffee Code ###

_.now()                 # => 1392066795351
```

```ruby
### Ruby Code ###

Time.now.to_i         
```

# underscore extension

## _.mixin(object)
_.mixin
  capitalize: (string)->
    string.charAt(0).toUpperCase() + string.substring(1).toLowerCase();
_.chain("fabio").capitalize();        # => "Fabio"

## _.noConflict()
```coffee
### Coffee Code ###

underscore = _.noConflict();
print _                 # => undefined
print underscore        # => function m()
```

## _.noop()
```
### Coffee Code ###

print _.noop any_args   # => undefined
```

## _.result(object, property, [defaultValue])
```coffee
### Coffee Code ###

object =
  cheese: 'crumpets'
  stuff: -> 'nonsense'

print _.result object, 'cheese'                 # => "crumpets"
print _.result(object, 'stuff');                # => "nonsense"
print _.result(object, 'meat')                  # => undefined
print _.result(object, 'meat', 'ham')           # => "ham"
```

## _.template()

```coffee
### Coffee Code ###
# for better performance, , we want top-level variables to be referenced as part of an object.
# or _.template("hello: <%= rc.name %>", variable: 'rc')

_.templateSettings.variable = "rc"

compiled = _.template("hello: <%= rc.name %>")
print compiled({name: 'moe'})                   # => hello: moe

compiled = _.template("<b><%- rc.value %></b>")
print compiled({value: '<script>'})             # => <b>&lt;script&gt;</b>
```

here a complete html example:

```html
### Html Code ###

<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Underscore.js Template</title>
  </head>
  <body>
    <h1></h1>

    <script type="text/template" id="template">
      Underscore.js Template by <font color=red><%= rc.name %></font>
    </script>

    <script src="http://underscorejs.org/underscore-min.js"></script>
    <script>
      _.templateSettings.variable = "rc";
      var html = document.getElementById('template').innerHTML;
      var compiledTemplate = _.template(html)({name: 'zw963'});
      document.getElementsByTagName('h1')[0].innerHTML = compiledTemplate;
    </script>
  </body>
</html>
```
