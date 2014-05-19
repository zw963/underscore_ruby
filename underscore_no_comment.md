# Javsscript underscore vs Ruby #

本文 underscore 的示例参考了 http://www.css88.com/doc/underscore/.
english version: http://underscorejs.org

## 实验环境 ##
仅以 Mac 为例, Linux 类似:

   1. brew install spidermonkey, 安装 js REPL.
   2. wget http://underscorejs.org/underscore-min.js, 下载 underscore 到本地.
   3. 运行 js, 启动 REPL, load('underscore-min.js')
      
Ruby 使用 irb 或 pry.


## 迭代器方法 ##

   1. _.each(list, iterator)
      
      ```js
      _.each([1, 2, 3], print);
      
      
      
      _.each([1, 2, 3], function (element, index, list) { print(element, index, list)});
      ```

      ```ruby
      Ruby:
      [1, 2, 3].each_with_index {|element, index| print element, index, [1, 2, 3], "\n" }
      ```
      
      ```js
      _.each({one: 1, two: 2, three: 3}, function (value, key) { print(value, key); });  
      
      
      
      ```
      
      ```ruby
      Ruby:
      {one: 1, two: 2, three: 3}.each {|key, value| print value, key, "\n" }  # 别名 each_pair
      ```
      
      注意: js function 参数是 (value, key), 而 Ruby 的 block 参数是 (key, value).
      
      这是因为 Ruby 采用并行赋值, 针对第一个元素 [one, 1], 会执行 key, value = [:one, 1]
      
      ```js
      _.each(list, function (element, index) { element.some_meth } 
      ```
      
      ```ruby
      Ruby:
      list.each(&:some_meth)
      ```
      
   2. _.map(list, iterator) 或 _.map([1, 2, 3], function_name)

      ```js
      _.map([1.0, 2.3, 3], Math.floor)  
      _.map([1.0, 2.3, 3], function (value, key, list) { return Math.floor(value) })
      ```
      
      ```ruby
      Ruby:
      [1.0, 2.3, 3].map {|element| Math.floor(element) }
      ```
      
   3. _.pluck(list, propertyName)
      
      ```js
      var stooges = [{name: 'moe', age: 40}, {name: 'larry', age: 50}, {name: 'curly', age: 60}];
      _.pluck(stooges, 'name')  
      _.map(stooges, function (element, index, list) { return element.name });
      ```
      
      ```ruby
      Ruby:
      stooges.map(&:size)  # => [2, 2, 2]
      ```
      
   4. _.invoke(list, methodName, *arguments) , pluck 的增强版, 支持为 name 传递参数.
      
      ```ruby
      Ruby:
      stooges.map {|e| e.[](:name) }
      stooges.map {|e| e[:name] }
      ```
      
   5. _.reduce(list, iterator, memo) 或 inject(list, iterator, momo)
      
      ```js
      _.reduce([1, 2, 3], function(memo, num){ return memo + num; }, 0); 
      ```
      
      ```ruby
      Ruby:
      [1, 2, 3].reduce(0) {|memo, num| memo + num }
      ```
      
   6. _.reduceRight(list, iterator, memo) 从右侧开始 reduce.
      
      ```js
      _.reduceRight([1, 2, 3], function(memo, num) { return memo << num; }, []) 
      ```
      
      ```ruby
      Ruby:
      [1, 2, 3].reverse_each.reduce([]) {|memo, num| memo << num }
      ```
      
   7. _.find(list, predicate)

      ```js
      _.find([1, 2, 3, 4, 5, 6], function(num) { return num % 2 == 0; }); 
      ```
      
      ```ruby
      Ruby:
      [1, 2, 3, 4, 5, 6].find {|e| e % 2 == 0 }
      ```
      
   8. _.filter(list, predicate) 或 select(list, predicate)
      
      ```js
      _.filter([1, 2, 3, 4, 5, 6], function(num){ return num % 2 == 0; }); 
      ```
      
      ```ruby
      [1, 2, 3, 4, 5, 6].select {|e| e % 2 == 0 } # 别名 find_all
      ```
      
   9. _.reject(list, predicate)
      
      ```js
      _.reject([1, 2, 3, 4, 5, 6], function(num) { return num % 2 == 0; }) 
      ```
      
      ```ruby
      Ruby:
      [1, 2, 3, 4, 5, 6].reject {|num| num % 2 == 0; }
      ```
      
   10. _.every/some(list, [predicate])  对应于 Ruby 的 all?/any?
       
       ```js
       _.every([true, 1, null, 'yes']) 
       _.every([true, 1, 'yes']) 
       ```
       
       ```ruby
       Ruby:
       [true, 1, nil, 'yes'].all?
       [true, 1, nil, 'yes'].all? {|e| e }
       ```
       
   11. _.contains(list, value) 或 _.include(list, value)
       
       ```js
       _.contains([1, 2, 3], 3); 
       ```
       
       ```ruby
       Ruby:
       [1, 2, 3].include? 3
       ```
       
   12. _.max/min/uniq(list, [iterator], [context]) 
        
       ```js
       _.max([1, 2, 3, 4, 5, 6]); 
       _.max([1, 2, 3, 4, 5, 6], function(num){ return Math.sin(num); }); 
       _.max([1, 2, 3, 4, 5, 6], Math.sin); // 简写形式
       ```
       
       ```ruby
       Ruby:
       [1, 2, 3, 4, 5, 6].max
       [1, 2, 3, 4, 5, 6].max {|e| Math.sin(e) }
       ```
       Ruby 不支持 js 样式的简写形式, 但是 Ruby 有神奇的: ``[1, 2, 3, 4, 5, 6].max(&:abs)``

   13. _.sortBy/groupBy(list, iterator)
   
       ```js
       _.sortBy([1, 2, 3, 4, 5, 6], Math.sin)
       _.sortBy([1, 2, 3, 4, 5, 6], function(num){ return Math.sin(num); }); 
       ```
        
       ```ruby
       Ruby:
       [1, 2, 3, 4, 5, 6].sort_by {|num| Math.sin(num) }
       ```

   14. _.indexBy 类似于 groupBy, 只不过适用于返回的结果只有一个元素时, 自动去除 [].
       
       ```js
       _.groupBy(['XXX', 'XXXX', 'XXXXX'], 'length'); 
       _.indexBy(['XXX', 'XXXX', 'XXXXX'], 'length'); 
       ```
       
       ```ruby
       Ruby:
       group_by {|x| ...}.map {|k, v| [k, *v] }
       group_by {|x| ...}.map {|k, v| [k, v.first] }
       ```

   15. _.countBy, 类似于 groupBy, 但是不返回元素, 而是返回元素的个数.
       
       ```js
       _.countBy([1, 2, 3, 4, 5], function(num) {  return num % 2 == 0 ? 'even': 'odd'; }); 
       
       ```
       
       ```ruby
       Ruby:
       group_by {|x| ...}.map {|k, v.count] }
       ```
       
   16. _.shuffle(list), 随机洗牌
       
       ```js
       _.shuffle([1, 2, 3, 4, 5, 6]); 
       ```
       
       ```ruby
       [1, 2, 3, 4, 5, 6].shuffle
       ```
       
   17. _.sample(list, [n]), 随机选取 n 个元素
       
       ```js
       _.sample([1, 2, 3, 4, 5, 6], 3) 
       ```
        
       ```ruby
       Ruby:
       [1, 2, 3, 4, 5, 6].sample(3)
       ```
       
   18. _.size(list)
      
      ```js
      _.size({one: 1, two: 2, three: 3}) 
      ```
      
      ```ruby
      Ruby:
      {one: 1, two: 2, three: 3}.size
      ```
      
   19. _.partition(array, predicate)
       
       ```js
       function isOdd(num) { return num % 2;}
       _.partition([0, 1, 2, 3, 4, 5], isOdd);
       ```
       
       ```ruby
       Ruby:
       [0, 1, 2, 3, 4, 5].partition {|e| e.odd? } 或 [0, 1, 2, 3, 4, 5].partition(&:odd?)
       ```
       
   20. _.where(list, properties) 返回 list 中, 包含 properties (子对象) 的对象数组.
       findWhere 仅仅返回第一个值. 这是 js 特有的方法. Ruby 下貌似没太大用途, 这里不实现了.
       
   21. _.toArray(list)
       
       ```js
       _.toArray(arguments), // => 转换任意可枚举对象为数组. 操作 arguments 时特别有用. 
       ```
       
       ```ruby
       Ruby:
       (1..10).to_a
       ```
       
## 数组方法 ##
   1. _.first/last(array, [n])
      
      ```js
      _.first([5, 4, 3, 2, 1], 2) 
      _.first([5, 4, 3, 2, 1], 2) 
      ```
      
      ```ruby
      Ruby:
      [5, 4, 3, 2, 1].first(2)
      [5, 4, 3, 2, 1].last(2)
      ```

   2. _.initial(array, [n]), 返回抛除 n 个元素后的数组.
      
      ```js
      _.initial([5, 4, 3, 2, 1], 2) 
      ```
      
      ```ruby
      Ruby:
      [1, 2, 3, 4][0...-2]
      [1, 2, 3, 4].drop(2)
      ```
      
   3. _.rest(array, [index]) 
      
      ```js
      _.rest([5, 4, 3, 2, 1], 2);
      ```
      
      ```ruby
      Ruby:
      [1, 2, 3, 4][2..-1]
      ```
      
   4. compact_.compact(array), 移除所有 `非真的元素'.
     
      ```js
      _.compact([0, 1, false, 2, '', 3]);  # => [1, 2, 3]
      ```
      
      ```ruby
      [0, false, '', nil].compact  # => [0, false, ''] 仅仅移除 nil.
      require 'active_support/all'
      [0, 1, false, 2, '', 3].reject {|x| x.blank? or x == 0 } # => [1, 2, 3]
      ```
      
   5. _.flatten(array, [shallow])
      
      ```js
      _.flatten([1, [2], [3, [4, 5], 6]]) 
      _.flatten([1, [2], [3, [4, 5], 6]], 1) 
      ```
      
      ```Ruby
      Ruby:
      [1, [2], [3, [4, 5], 6]].flatten
      [1, [2], [3, [4, 5], 6].flatten(1)
      ```
      
   6. _.without(array, *values)
      
      ```js
     _.without([1, 2, 1, 0, 3, 1, 4], 0, 1);  
     ```
     
      ```ruby
      Ruby:
      [1, 2, 1, 0, 3, 1, 4].reject {|x| x == 1 or x == 0 } # => [2, 3, 4]
      ```
      
   7. _.union(*arrays)
      
      ```js
      _.union([1, 2, 3], [101, 2, 1, 10]) 
      ```
      
      ```ruby
      Ruby:
      [1, 2, 3] | [101, 2, 1, 10]
      ```
      
   8. _.intersection(*arrays)
      
      ```js
      _.intersection([1, 2, 3], [101, 2, 1, 10]) 
      ```
      
      ```ruby
      Ruby:
      [1, 2, 3] & [101, 2, 1, 10]
      ```
      
   9. _.difference(array, *others)
      
      ```js
      _.difference([1, 2, 3, 4, 5], [5, 2, 10]); 
      ```
      
      ```ruby
      Ruby:
      [1, 2, 3, 4, 5] - [5, 2, 10]
      ```
       
   10. _.zip(*arrays)
       
       ```js
       _.zip(['moe', 'larry', 'curly'], [30, 40, 50], [true, false, false])
       
       
       
       
       
       ```
       
       ```ruby
       Ruby:
       ['moe', 'larry', 'curly'].zip([30, 40, 50], [true, false, false])
       ```
       
   11. _.object(list, [values]), 转化 values 到 js 对象形式, js 特有的方法.
       
       ```js
       _.object(['moe', 'larry', 'curly'], [30, 40, 50]); 
       _.object([['moe', 30], ['larry', 40], ['curly', 50]]); 
       ```
       
       ```ruby
       Ruby: 
       x = ['moe', 'larry', 'curly'].zip[30, 40, 50]  # => [['moe', 30], ['larry', 40], ['curly', 50]]
       
       Hash[x]      # => {moe: 30, larry: 40, curly: 50}
       Hash[y]      # => {moe: 30, larry: 40, curly: 50}
       ```
       
   12. _.indexOf/lastIndexOf(array, value), 返回 value 在 array 中的索引, 不存在返回 -1.
       
       ```js
       _.indexOf([1, 2, 3, 1, 2, 3], 2); 
       _.lastIndexOf([1, 2, 3, 1, 2, 3], 2) 
       ```
       
       ```ruby
       Ruby: (不存在会返回 nil)
       [1, 2, 3, 1, 2, 3].index(2)      # => 1
       [1, 2, 3, 1, 2, 3].rindex(2)     # => 4
       ```

   13. _.range([start], stop, [step])
       
       ```js
       _.range(0, 30, 5); 
       ```
       
       ```ruby
       (0..30).step(5)
       ```
   
   14. _.sortedIndex(list, value, [iterator], [context]), 返回参数插入 `排序后的数组' 时, 应该被插入的索引位置.
       
       ```js
       _.sortedIndex([10, 20, 30, 40, 50], 35); 
       ```
       
       Ruby 版: 没有对应实现, 可以自己写一个:
       ```ruby
       Ruby:
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
      _.keys({one: 1, two: 2}); 
      ```
      
      ```ruby
      Ruby:
      {one: 1, two: 2}.keys     # => [:one, :two]
      ```
      
   2. _.values(object) 
      
      ```js
      _.values({one: 1, two: 2});  
      ```
      
      ```ruby
      Ruby:
      {one: 1, two: 2}.values
      ```
      
   3. _.pairs(object)
      
      ```js
      _.pairs({one: 1, two: 2}); 
      ```
      
      ```ruby
      Ruby:
      {one: 1, two: 2}.to_a
      ```
      
   4. _.invert(object), 翻转
      
      ```js
      _.invert({Moe: "Moses", Larry: "Louis"}); 
      ```
      
      ```ruby
      Ruby:
      {Moe: "Moses", Larry: "Louis"}  # => {"Moses" => :Moe, "Louis" => :Larry}
      ```
   5. _.functions(object) 或别名 _.methods(object), 返回某个对象之上可用的所有方法.
      
      ```js
      _.functions(_); 
      // =>
      // ["after", "all", "any", "bind", "bindAll", "chain", "clone", "collect", "compact", "compose",
      // "constant", "contains", "countBy", "debounce", "defaults", "defer", "delay", "detect", 
      // "difference", "drop", "each", "escape", "every", "extend", "filter", "find", "findWhere", 
      // "first", "flatten", "foldl", "foldr", "forEach", "functions", "groupBy", "has", "head", 
      // "identity", "include", "indexBy", "indexOf", "initial", "inject", "intersection", "invert", 
      // "invoke", "isArguments", "isArray", "isBoolean", "isDate", "isElement", "isEmpty", "isEqual", 
      // "isFinite", "isFunction", "isNaN", "isNull", "isNumber", "isObject", "isRegExp", "isString", 
      // "isUndefined", "keys", "last", "lastIndexOf", "map", "matches", "max", "memoize", "methods", 
      // "min", "mixin", "noConflict", "now", "object", "omit", "once", "pairs", "partial", "partition", 
      // "pick", "pluck", "property", "random", "range", "reduce", "reduceRight", "reject", "rest", 
      // "result", "sample", "select", "shuffle", "size", "some", "sortBy", "sortedIndex", "tail", 
      // "take", "tap", "template", "throttle", "times", "toArray", "unescape", "union", "uniq", 
      // "unique", "uniqueId", "values", "where", "without", "wrap", "zip"]
      ```
      
      ```ruby
      Ruby:
      object.methods
      ```

   6. _.extend(destination, *sources),  合并 sources 到 destination, 并返回修改后的 destination.
      
      ```js
      _.extend({name: 'moe'}, {name: 'larry', age: 30});  
      ```
      
      ```ruby
      Ruby:
      {name: 'moe'}.merge! name: 'larry', age: 30
      ```

   9. _.defaults(object, *defaults), 合并不存在的 defaults 到 object, 返回修改后的 object.
      
      ```
      _.default({name: 'moe'}, {name: 'larry', age: 30});  
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
      _.pick({name: 'moe', age: 50, userid: 'moe1'}, 'name', 'age') 
      ```
      
      ```ruby
      Ruby:
      {name: 'moe', age: 50, userid: 'moe1'}.assoc(:name), # => 仅支持一个参数.
      {name: 'moe', age: 50, userid: 'moe1'}.select {|k,v| k == :name or k == :age }
      ```

   8. _.omit(object, *keys)

      ```js
      _.omit({name: 'moe', age: 50, userid: 'moe1'}, 'userid') 
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

   func.call({name: 'moe'}, 'hi')       
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
      new_func(); 
      ```
      
## 总结 ##
   1. underscore 的第一个参数就是 Ruby 中的 receiver(self), 并在 self 之上调用同名方法.
      js 之中的 function (x) { ... } 换做 Ruby 之中的 Block, {|x| ... }, 省略 return 就可以了.
   2. Js 和 Ruby 的 call, 唯一的差别是: 
      - Js 第一个参数是 this, 其余的参数传递给方法作为参数.
      - Ruby 单独通过 bind 绑定 self, call 仅接受传递给方法的参数.
   3. 如果用 Coffee 写 Js, 那就完美了.
      
