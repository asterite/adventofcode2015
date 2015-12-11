# Alternative solution inspired by https://www.reddit.com/r/adventofcode/comments/3wbzyv/day_11_solutions/cxv1vx5
# (runs much slower than my original solution, but it's much more readable)
stairs = [] of String
('a'..'z').each_cons(3) do |chars|
  stairs << chars.join
end
stairs = Regex.union(stairs)

input = "hxbxxyzz"
loop do
  input = input.succ
  if input =~ stairs && !(input =~ /i|o|l/) && input.scan(/(\w)\1/).size > 1
    break
  end
end
puts input
