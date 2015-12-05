input = File.read("#{__DIR__}/input")
nice_count = input.each_line.count do |line|
  line =~ /(..).*\1/ && line =~ /(.).\1/
end
puts nice_count
