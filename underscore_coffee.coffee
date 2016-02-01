window.print = (x...)->
  console.log x...

print _.map [1, 2, 3, 4], (x)->
  x * x
# => Array [ 1, 4, 9, 16 ]
