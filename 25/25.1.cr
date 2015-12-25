col = 1
row = 1
value = 20151125_i64
while true
  row -= 1
  col += 1
  value = (value * 252533) % 33554393
  break if row == 2978 && col == 3083
  if row == 0
    row = col
    col = 1
  end
end
puts value
