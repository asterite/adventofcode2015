input = File.read("#{__DIR__}/input")
puts input.count('(') - input.count(')')
