input = File.read("#{__DIR__}/input")
length = input.each_line.sum do |line|
  l, w, h = line.split('x').map(&.to_i)
  min = {l + w, w + h, h + l}.min
  2*min + l*w*h
end
puts length
