stairs = Regex.union(('a'..'z').each_cons(3).map(&.join).to_a)

input = "hxbxwxba"
loop do
  input = input.succ
  if input =~ stairs && !(input =~ /i|o|l/) && input.scan(/(\w)\1/).size > 1
    break
  end
end
puts input
