input = File.read("#{__DIR__}/input")
containers = input.split.map(&.to_i)

all = [] of typeof(containers)
(1..containers.size).each do |size|
  containers.each_combination(size) do |combination|
    all << combination if combination.sum == 150
  end
end

min = all.min_of &.size
min_count = all.count { |comb| comb.size == min }
puts min_count
