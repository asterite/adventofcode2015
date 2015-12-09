cities = Set(String).new
routes = {} of {String, String} => Int32

# Read cities and routes
input = File.read("#{__DIR__}/input")
input.each_line do |line|
  if line =~ /(\w+) to (\w+) = (\d+)/
    from, to, distance = $1, $2, $3.to_i
    cities << from
    cities << to
    routes[{from, to}] = distance
    routes[{to, from}] = distance
  end
end

# Find out the minimum distance amongst each cities permutation
min_distance = Int32::MAX
cities.to_a.each_permutation do |permutation|
  distance = 0.upto(permutation.size - 2).sum do |i|
    routes[{permutation[i], permutation[i + 1]}]
  end
  min_distance = {min_distance, distance}.min
end
puts min_distance
