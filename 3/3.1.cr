# Since the file is small (8Kb) we use Int32, but we could use BigInt
# (because the problem mentions an "infinite two-dimensional grid")
x = 0
y = 0

visits = Set{ {0, 0} }

input = File.read("#{__DIR__}/input")
input.each_char do |char|
  case char
  when '^' then y -= 1
  when 'v' then y += 1
  when '>' then x += 1
  when '<' then x -= 1
  end
  visits << {x, y}
end

puts visits.size
