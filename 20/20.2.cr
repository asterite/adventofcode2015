target = 33100000
size = target / 10
counts = Array.new(size, 0)
1.upto(size) do |n|
  counter = 0
  n.step(by: n, limit: size - 1) do |i|
    counts[i] += 11 * n
    counter += 1
    break if counter == 50
  end
end
puts counts.index { |c| c >= target }
