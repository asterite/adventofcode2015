input = File.read("#{__DIR__}/input")
area = input.each_line.sum do |line|
  l, w, h = line.split('x').map(&.to_i)
  min = {l*w, w*h, h*l}.min
  2 * (l*w + w*h + h*l) + min
end
puts area
