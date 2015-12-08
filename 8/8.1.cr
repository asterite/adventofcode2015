diff = 0
input = File.read("#{__DIR__}/input")
input.each_line do |line|
  iter = line.each_char
  iter.next
  diff += 2 # For the opening and closing quote
  while true
    case iter.next
    when '"'
      break
    when '\\'
      case iter.next
      when '"', '\\'
        diff += 1 # \" vs ", or \\ vs \
      when 'x'
        iter.next
        iter.next
        diff += 3 # \x41 vs a
      end
    end
  end
end
pp diff
