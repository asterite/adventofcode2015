input = File.read("#{__DIR__}/input")
containers = input.split.map(&.to_i)

count = 0
(1..containers.size).each do |size|
  containers.each_combination(size) do |combination|
    count += 1 if combination.sum == 150
  end
end
puts count
