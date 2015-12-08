diff = 0
input = File.read("#{__DIR__}/input")
input.each_line do |line|
  iter = line.each_char
  iter.next # Skip opening quote
  diff += 4 # For the opening and closing quote
  while true
    case iter.next
    when '"'
      break
    when '\\'
      case iter.next
      when '"', '\\'
        diff += 2 # \" vs \\\", or \\ vs \\\\
      when 'x'
        iter.next
        iter.next
        diff += 1 # \x41 vs \\x41
      end
    end
  end
end
pp diff
