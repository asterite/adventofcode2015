input = File.read("#{__DIR__}/input")
lines = input.lines

reg = {"a" => 0, "b" => 0}
i = 0
while i < lines.size
  line = lines[i]
  case line
  when /hlf (\w)/
    reg[$1] /= 2
  when /tpl (\w)/
    reg[$1] *= 3
  when /inc (\w)/
    reg[$1] += 1
  when /jmp ((?:\+|\-)\d+)/
    i += $1.to_i
    next
  when /jie (\w), ((?:\+|\-)\d+)/
    if reg[$1].even?
      i += $2.to_i
      next
    end
  when /jio (\w), ((?:\+|\-)\d+)/
    if reg[$1] == 1
      i += $2.to_i
      next
    end
  else
    raise "Unknown instruction: #{line}"
  end

  i += 1
end
puts reg["b"]
