target = 33100000
size = target / 10
counts = Array.new(size, 10)
2.upto(size) do |n|
  n.step(by: n, limit: size - 1) do |i|
    counts[i] += 10 * n
  end
end
puts counts.index { |c| c >= target }
