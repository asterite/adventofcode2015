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

# Find out the maximum distance amongst each cities permutation
max_distance = 0
cities.to_a.each_permutation do |permutation|
  this_distance = 0
  0.upto(permutation.size - 2) do |i|
    from, to = permutation[i], permutation[i + 1]
    if path_distance = routes[{from, to}]?
      this_distance += path_distance
    else
      this_distance = 0
      break
    end
  end
  max_distance = {max_distance, this_distance}.max
end
puts max_distance
