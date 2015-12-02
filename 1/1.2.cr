input = File.read("#{__DIR__}/input")

floor = 0
input.each_char_with_index do |char, index|
  case char
  when '('
    floor += 1
  when ')'
    floor -= 1
    if floor == -1
      puts index + 1
      break
    end
  end
end
