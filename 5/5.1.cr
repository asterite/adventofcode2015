input = File.read("#{__DIR__}/input")
nice_count = input.each_line.count do |line|
  line.count("aeiou") >= 3 && line =~ /(.)\1/ && !(line =~ /ab|cd|pq|xy/)
end
puts nice_count
